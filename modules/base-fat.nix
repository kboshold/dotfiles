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
    nerd-fonts.jetbrains-mono
  ];
  home.file = {
    ".config/eza".source = ../config/eza;
    ".config/fish".source = ../config/fish;
    ".config/atuin".source = ../config/atuin;
    ".config/mise".source = ../config/mise;
    ".config/nushell".source = ../config/nushell;
    ".config/oh-my-posh".source = ../config/oh-my-posh;
    ".config/starship".source = ../config/starship;
    ".config/zsh".source = ../config/zsh;
    ".config/zellij".source = ../config/zellij;
    ".config/.fdignore".source = ../config/fdignore;
    ".config/.rgignore".source = ../config/rgignore;
  };
}
