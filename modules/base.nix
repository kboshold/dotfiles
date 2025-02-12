{ config, pkgs, ... }:
{
  home.stateVersion = "24.11";
  home.username = builtins.getEnv "USER";
  home.homeDirectory = if builtins.getEnv "HOME" == ""
    then "/home/${builtins.getEnv "USER"}"
    else builtins.getEnv "HOME";
  


  home.packages = with pkgs; [
    neovim
    tmux
    git
  ];
  
  home.file = {
    "~/.config/nvim".source = ../config/nvim;
    "~/.config/tmux".source = ../config/tmux;
    "~/.config/bash".source = ../config/bash;
    "~/.bashrc".text = ''
      if [ -f "$HOME/.config/bash/config.bash" ]; then
        . "$HOME/.config/bash/config.bash"
      fi
    '';
  };

}