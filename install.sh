#!/bin/bash

# Install Nix and Home Manager (if not already installed)
install_nix_home_manager() {
  if ! command -v nix &> /dev/null; then
    echo "Installing Nix..."
    sh <(curl -L https://nixos.org/nix/install) --daemon
    source $HOME/.nix-profile/etc/profile.d/nix.sh
  fi

  if ! command -v home-manager &> /dev/null; then
    echo "Installing Home Manager..."
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install
  fi
}

# Check required packages
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

    # Check if auto-install is enabled
    if [ "${DOTFILES_AUTOINSTALL,,}" = "true" ]; then
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

# Set default values if not provided
if [ -z "${DOTFILES_DIR}" ]; then
  DOTFILES_DIR="$HOME/.local/dotfiles"
fi

if [ -z "${DOTFILES_AUTOINSTALL}" ]; then
  DOTFILES_AUTOINSTALL="false"
fi

if [ -z "${DOTFILES_AUTOSETUP}" ]; then
  DOTFILES_AUTOSETUP="false"
fi
if [ "${DOTFILES_AUTOSETUP,,}" = "true" ]; then
  DOTFILES_AUTOINSTALL="true"
fi

if [ -z "${DOTFILES_MODE}" ]; then
  DOTFILES_MODE="home"
fi

DOTFILES_REPO="https://github.com/kboshold/dotfiles.git"

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to get the remote origin URL of a git repository
get_remote_origin_url() {
    local dir="$1"
    git -C "$dir" config --get remote.origin.url
}

# Determine if we're running from within a git repo
if git -C "$SCRIPT_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    # We're in a git repo, get the root of that repo
    REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)"
    
    # Get the remote origin URL
    REMOTE_URL=$(get_remote_origin_url "$REPO_ROOT")
    
    # Normalize the URLs for comparison (remove .git suffix and handle SSH format)
    NORMALIZED_REMOTE=${REMOTE_URL%.git}
    NORMALIZED_REMOTE=${NORMALIZED_REMOTE#git@github.com:}
    NORMALIZED_REMOTE=${NORMALIZED_REMOTE#https://github.com/}
    
    NORMALIZED_DOTFILES=${DOTFILES_REPO%.git}
    NORMALIZED_DOTFILES=${NORMALIZED_DOTFILES#git@github.com:}
    NORMALIZED_DOTFILES=${NORMALIZED_DOTFILES#https://github.com/}
    
    # Check if we're in the correct repo or in Codespaces
    if [ "$NORMALIZED_REMOTE" = "$NORMALIZED_DOTFILES" ] || [ "$CODESPACES" = "true" ]; then
        echo "Using existing repository at $REPO_ROOT"
        DOTFILES_DIR="$REPO_ROOT"
    else
        echo "Current repository is not the dotfiles repository"
        if [ ! -d "$DOTFILES_DIR" ]; then
            echo "Cloning the dotfiles repository into $DOTFILES_DIR..."
            git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
        else
            echo "Dotfiles repository already exists at $DOTFILES_DIR."
        fi
    fi
else
    # We're not in a git repo, use the default behavior with cloning
    if [ ! -d "$DOTFILES_DIR" ]; then
        echo "Cloning the dotfiles repository into $DOTFILES_DIR..."
        git clone --depth=1 "$DOTFILES_REPO" "$DOTFILES_DIR"
    else
        echo "Dotfiles repository already exists at $DOTFILES_DIR."
    fi
fi

# List of required programs
required_programs=(git curl)

# Check and install required packages
check_missing_packages

# Install Nix and Home Manager
install_nix_home_manager

# Apply the Home Manager configuration
if [ -d "$DOTFILES_DIR" ]; then
    echo "Applying Home Manager configuration..."
    home-manager switch --flake "$DOTFILES_DIR#$DOTFILES_MODE"
else
    echo "Error: Dotfiles directory not found. Cannot apply configuration."
    exit 1
fi

echo "Done!"
