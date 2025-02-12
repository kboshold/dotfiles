{ config, pkgs, ... }:
{
  home.stateVersion = "24.11";
  home.username = builtins.getEnv "USER";
  home.homeDirectory = if builtins.getEnv "HOME" == ""
    then "/home/${builtins.getEnv "USER"}"
    else builtins.getEnv "HOME";

  home.packages = with pkgs; [
    gcc
    gnumake
    neovim
    fish
    tmux
    git
  ];

  home.file = {
    ".config/bash".source = ../config/bash;
    ".bashrc".source = config.ux.symlink ../config/bash/dot_bashrc;
    ".config/nvim".source = config.ux.symlink ../config/nvim;
    ".config/fish".source = config.ux.symlink ../config/fish;
    ".config/tmux".source = config.ux.symlink ../config/tmux;
  };
}

