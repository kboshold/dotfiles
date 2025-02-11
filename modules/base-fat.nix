{ config, pkgs, ... }:
{
  imports = [ ./base.nix ];

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    bat
    fzf
    ripgrep
    eza
    mise
    fish
    atuin
    nushell
    starship
    # zellij
    # zsh
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home.file."~/.config/eza" = {
    source = ./config/eza;
    recursive = true;
  };

  home.file."~/.config/fish" = {
    source = ./config/fish;
    recursive = true;
  };

  home.file."~/.config/atuin" = {
    source = ./config/atuin;
    recursive = true;
  };

  home.file."~/.config/mise" = {
    source = ./config/mise;
    recursive = true;
  };

  home.file."~/.config/nushell" = {
    source = ./config/nushell;
    recursive = true;
  };

  home.file."~/.config/oh-my-posh" = {
    source = ./config/oh-my-posh;
    recursive = true;
  };

  home.file."~/.config/starship" = {
    source = ./config/starship;
    recursive = true;
  };

  home.file."~/.config/zsh" = {
    source = ./config/zsh;
    recursive = true;
  };

  home.file."~/.config/zellij" = {
    source = ./config/zellij;
    recursive = true;
  };

  home.file."~/.config/.fdignore" = ./config/fdignore;
  home.file."~/.config/.rgignore" = ./config/rgignore;
}