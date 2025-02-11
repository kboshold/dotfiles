{ config, pkgs, ... }:
{
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim
    tmux
    git
  ];

  home.file."~/.config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };

  home.file."~/.config/tmux" = {
    source = ./config/tmux;
    recursive = true;
  };
}