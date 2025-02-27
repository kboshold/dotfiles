#!/bin/bash

set -e

check_missing_packages() {
	missing_packages=()
	for program in "${required_programs[@]}"; do
		if ! command -v "$program" &> /dev/null; then
			missing_packages+=("$program")
		fi
	done

	if [ ${#missing_packages[@]} -gt 0 ]; then
		echo "Some required packages are missing: ${missing_packages[*]}"

	# Detect OS and set package manager command
	if [ -f /etc/debian_version ]; then
		PM_COMMAND="apt"
		INSTALL_CMD="sudo apt install ${missing_packages[*]} -y"
	elif [ -f /etc/fedora-release ]; then
		PM_COMMAND="dnf"
		INSTALL_CMD="sudo dnf install ${missing_packages[*]} -y"
	elif [ -f /etc/arch-release ]; then
		PM_COMMAND="pacman"
		INSTALL_CMD="sudo pacman -S ${missing_packages[*]}"
	else
		echo "Unsupported operating system"
		exit 1
	fi

	echo "Detected package manager: $PM_COMMAND"

	if [ "${DF_AUTOINSTALL,,}" = "true" ]; then
		echo "Auto-installing missing packages..."
		eval "$INSTALL_CMD"
		if [ $? -ne 0 ]; then
			echo "Failed to install packages"
			exit 1
		fi
	else
		read -p "Do you want to install the missing packages automatically? (y/n) " -n 1 -r
		echo
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			echo "Installing missing packages..."
			eval "$INSTALL_CMD"
			if [ $? -ne 0 ]; then
				echo "Failed to install packages"
				exit 1
			fi
		else
			echo "Please install the missing packages manually using:"
			echo "$INSTALL_CMD"
			exit 1
		fi
	fi
	fi
}


# Function to get the remote origin URL
get_remote_origin_url() {
	local dir="$1"
	git -C "$dir" config --get remote.origin.url
}

# Clone or update repository with submodules
clone_or_update_repo() {
	local target_dir="$1"
	if [ ! -d "$target_dir" ]; then
		git clone --recursive "$DF_REPO" "$target_dir"
		git -C "$target_dir" submodule update --init --recursive
	else
		git -C "$target_dir" fetch origin
		git -C "$target_dir" pull --recurse-submodules
		git -C "$target_dir" submodule update --init --recursive
	fi
}

setup_project() {
	# Handle repository setup
	if git -C "$SCRIPT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
		REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)"
		REMOTE_URL=$(get_remote_origin_url "$REPO_ROOT")

		NORMALIZED_REMOTE=${REMOTE_URL%.git}
		NORMALIZED_REMOTE=${NORMALIZED_REMOTE#git@github.com:}
		NORMALIZED_REMOTE=${NORMALIZED_REMOTE#https://github.com/}

		NORMALIZED_DF=${DF_REPO%.git}
		NORMALIZED_DF=${NORMALIZED_DF#git@github.com:}
		NORMALIZED_DF=${NORMALIZED_DF#https://github.com/}

		if [ "$NORMALIZED_REMOTE" = "$NORMALIZED_DF" ] || [ "$CODESPACES" = "true" ]; then
			DF_DIR="$REPO_ROOT"
			git -C "$DF_DIR" submodule update --init --recursive

		# Disable git generation for codespaces
		if [ "$CODESPACES" = "true" ]; then
			sed -i 's/^\[git\]/[git_disabled]/' "$DF_DIR/data.toml"
		fi
	else
		clone_or_update_repo "$DF_DIR"
		fi
	else
		clone_or_update_repo "$DF_DIR"
	fi
}

install_gum() {
    # Detect OS and architecture
    OS=$(uname -s)
    ARCH=$(uname -m)

    # Convert architecture names
    case ${ARCH} in
        x86_64)  ARCH="x86_64" ;;
        aarch64) ARCH="arm64" ;;
        armv7l)  ARCH="armv7" ;;
        *)       echo "Unsupported architecture: ${ARCH}"; exit 1 ;;
    esac

    # Convert OS names
    case ${OS} in
        Darwin) OS="Darwin" ;;
        Linux)  OS="Linux" ;;
        *)      echo "Unsupported operating system: ${OS}"; exit 1 ;;
    esac

    # Get latest version using GitHub API
    VERSION=$(curl -s https://api.github.com/repos/charmbracelet/gum/releases/latest | grep -o '"tag_name": ".*"' | cut -d'"' -f4)
    FILENAME="gum_${VERSION#v}_${OS}_${ARCH}.tar.gz"

    TMP_DIR=$(mktemp -d)

    # Download and extract
    curl -sL "https://github.com/charmbracelet/gum/releases/download/${VERSION}/${FILENAME}" -o "${TMP_DIR}/${FILENAME}"
    tar xzf "${TMP_DIR}/${FILENAME}" --strip-components=1 -C "${TMP_DIR}"

    GUM="${TMP_DIR}/gum"
}

install_nix() {
	if ! command -v nix &> /dev/null; then
		sudo apt-get update
		sudo apt-get install -y acl && sudo setfacl -k /tmp

		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sudo sh -s -- install --no-confirm
		sudo chown -R $(whoami):$(whoami) /nix
		. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
		. /nix/var/nix/profiles/default/etc/profile.d/nix.sh

	fi
}

install_home_manager() {
	if ! command -v home-manager &> /dev/null; then
		sudo mkdir -p /nix/var/nix/profiles/per-user/$(whoami)
		sudo mkdir -p /nix/var/nix/gcroots/per-user/$(whoami)
		sudo chown -R $(whoami):$(whoami) /nix/var/nix/profiles/per-user/$(whoami)
		sudo chown -R $(whoami):$(whoami) /nix/var/nix/gcroots/per-user/$(whoami)

		# Add channels as user
		nix-channel --add https://nixos.org/channels/nixpkgs-unstable
		nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
		nix-channel --update
	
		# Install home-manager 
		nix-shell '<home-manager>' -A install
	
		# Create the profile directory if it doesn't exist
		mkdir -p $HOME/.nix-profile/etc/profile.d
	 fi
}

apply_home_manager() {
	if [ -d "$DF_DIR" ]; then
		home-manager switch --flake "$DF_DIR?submodules=1#$DF_MODE" --impure -b bckp
	fi
}

# Set default values if not provided
DF_DIR="${DF_DIR:-$HOME/.local/share/dotfiles}"
DF_AUTOINSTALL="${DF_AUTOINSTALL:-false}"
DF_AUTOSETUP="${DF_AUTOSETUP:-false}"
DF_MODE="${DF_MODE:-${CODESPACES:+codespaces}}"
DF_MODE="${DF_MODE:-home}"

if [ "${DF_AUTOSETUP,,}" = "true" ]; then
	DF_AUTOINSTALL="true"
fi

DF_REPO="https://github.com/kboshold/dotfiles.git"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

required_programs=(git curl tar)
check_missing_packages

install_gum

$GUM spin --title "Setup Project" setup_project
$GUM spin --title "Installing Nix" install_nix
$GUM spin --title "Installing Home-Manager" install_home_manager
$GUM spin --title "Appling Home-Manager Configuration" apply_home_manager

