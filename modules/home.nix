{ config, pkgs, ... }:
{
  imports = [ ./base-fat.nix ];

  home.packages = with pkgs; [];
}