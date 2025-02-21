{ config, pkgs, ... }:
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
		git
	];

	home.file = {
		".config/bash".source = ../config/bash;
		".bashrc".source = ../config/bash/dot_bashrc;
		".config/nvim".source = ../config/nvim;
		".config/fish".source = ../config/fish;
		".config/tmux".source = ../config/tmux;
	};
}

