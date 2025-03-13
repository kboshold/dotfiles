{ config, pkgs, lib, ... }:
{
  imports = [ ./base-fat.nix ];


  home.packages = with pkgs; [
    chromedriver
    ansible
    kubectl
    wslu
    flutter
  ];


  home.sessionVariables =  {
    XDG_RUNTIME_DIR = "/tmp";
    CHROME_EXECUTABLE = "wslview";
    BROWSER = "wslview";
  };
}

