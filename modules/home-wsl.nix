{ config, pkgs, lib, ... }:
{
  imports = [ ./base-fat.nix ];

  home.packages = with pkgs; [
    flutter
    chromedriver
    ansible
    kubectl

    wslu
  ];

  home.sessionVariables =  {
    XDG_RUNTIME_DIR = "/tmp";
    CHROME_EXECUTABLE = "wslview";
    BROWSER = "wslview";
  };
}

