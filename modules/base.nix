{ config, pkgs, lib, data, ... }:
{

	home.stateVersion = "24.11";
	home.username = lib.mkDefault (builtins.getEnv "USER");
	home.homeDirectory = lib.mkDefault (if builtins.getEnv "HOME" == ""
		then "/home/${builtins.getEnv "USER"}"
	else builtins.getEnv "HOME");

	nixpkgs.config.allowUnfree = true;

	home.packages = with pkgs; [
		home-manager
		gcc
		gnumake
		neovim
		fish
		tmux
		curl
		jq
	];

	home.file = {
		".config/bash".source = ../config/bash;
		".config/nvim".source = ../config/nvim;
		".config/fish".source = ../config/fish;
		".config/tmux".source = ../config/tmux;
		".config/git/allowed_signers".text = lib.optionalString (data ? git && data.git.signkey != null)
			"${data.git.email} ${data.git.signkey}";
		".ssh/gitsign.pub".text = lib.optionalString (data ? git && data.git.signkey != null)
			"${data.git.signkey} ${data.git.email}";
	};

	home.activation.neovimSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
		${pkgs.neovim}/bin/nvim --headless -c 'Lazy install' -c 'qa'
	'';

	programs.bash = {
		enable = true;
		initExtra = ''
			if [ -f "$HOME/.config/bash/config.bash" ]; then
				. "$HOME/.config/bash/config.bash"
			fi
		'';
	};

	programs.git = lib.optionalAttrs (data ? git) { 
		enable = true;
		userName = lib.optionalString (data.git.name != null) data.git.name;
		userEmail = lib.optionalString (data.git.email != null) data.git.email;
		extraConfig = lib.optionalAttrs (data.git.signkey != null) {
			gpg.format = "ssh";
			gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
			commit.gpgSign = true;
			tag.gpgSign = true;
			user.signingKey = "~/.ssh/gitsign.pub";
		};
	};
}

