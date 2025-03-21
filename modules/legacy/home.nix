{ config, pkgs, lib, ... }:
{
  imports = [ ./base-fat.nix ];

  home.packages = with pkgs; [
    flutter
    chromedriver
    google-chrome
    ansible
    kubectl
  ];

  home.sessionVariables = {
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome";
  };
}

