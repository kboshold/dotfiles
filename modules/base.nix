{ config, pkgs, lib, ... }:
{

	home.stateVersion = "24.11";
	home.username = builtins.getEnv "USER";
	home.homeDirectory = if builtins.getEnv "HOME" == ""
		then "/home/${builtins.getEnv "USER"}"
	else builtins.getEnv "HOME";

	home.packages = with pkgs; [
		home-manager
		gcc
		gnumake
		neovim
		fish
		tmux
	];

	home.file = {
		".config/bash".source = ../config/bash;
		".bashrc".source = ../config/bash/dot_bashrc;
		".config/nvim".source = ../config/nvim;
		".config/fish".source = ../config/fish;
		".config/tmux".source = ../config/tmux;
		".config/git/allowed_signers".source = ../config/git/allowed_signers;
	};

	home.activation.neovimSetup = lib.hm.dag.entryAfter ["writeBoundary"] ''
		$DRY_RUN_CMD ${pkgs.neovim}/bin/nvim --headless -c 'Lazy install' -c 'qa'
	'';

	programs.git = {
		enable = true;
		userName = "Kevin Boshold";
		userEmail = "github@proxy.boshol.de";
		extraConfig = {
			gpg.format = "ssh";
			gpg.ssh.allowedSignersFile = "~/.config/git/allowed_signers";
			commit.gpgSign = true;
			tag.gpgSign = true;
			user.signingKey = "~/.ssh/gitsign.pub";
		};
	};


}

