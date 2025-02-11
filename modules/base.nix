{ config, pkgs, ... }:
{
  home.username = "kboshold";
  home.homeDirectory = "/home/kboshold";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    neovim
    tmux
    git
  ];
  
  home.file = {
    "~/.config/nvim".source = ../config/nvim;
    "~/.config/tmux".source = ../config/tmux;
  };

}