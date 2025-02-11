{ config, pkgs, ... }:
{
  imports = [ 
    ./server.nix
    ./base-fat.nix
  ];

  home.packages = with pkgs; [];
}