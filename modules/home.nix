{ config, pkgs, lib, ... }:
let
  isWSL = builtins.getEnv "WSL_DISTRO_NAME" != "";
in {
  imports = [ ./base-fat.nix ];

  home.packages = with pkgs; [
    flutter
    chromedriver
    jq
    ansible
    kubectl
  ];

  home.sessionVariables = (if isWSL then {
    XDG_RUNTIME_DIR = "/tmp";
    CHROME_EXECUTABLE = "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe";
  } else {
    CHROME_EXECUTABLE = "${pkgs.google-chrome}/bin/google-chrome";
  });
}

