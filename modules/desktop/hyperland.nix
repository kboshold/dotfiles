{ config, pkgs, lib, ... }:
{
  imports = [ ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # Core utilities
    waybar        # Status bar
    wofi          # App launcher
    dunst         # Notification daemon
    swww          # Wallpaper daemon
    wl-clipboard  # Clipboard utilities
    hyprpicker    # Color picker
    grimblast     # Screenshot utility
    
    # System utilities
    networkmanagerapplet
    blueman
    pavucontrol
    brightnessctl
    
    # File management
    thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    
    # Media
    mpv
    imv           # Image viewer
    
    # Terminal and tools
    kitty
    libnotify
  ];

  # Enable services
  services = {
    gtklock.enable = true;  # Screen locker
    
    # Pipewire for audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  # XDG portal for screensharing
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Set default home-manager configuration for Hyprland
  home-manager.users.${config.user.name} = { pkgs, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      extraConfig = ''
        # Monitor configuration
        monitor=,preferred,auto,1

        # Set variables
        $terminal = kitty
        $menu = wofi --show drun
        $browser = firefox
        $fileManager = thunar
        $locker = gtklock

        # Some default env vars
        env = XCURSOR_SIZE,24

        # Input configuration
        input {
            kb_layout = us
            follow_mouse = 1
            touchpad {
                natural_scroll = true
            }
            sensitivity = 0
        }

        # General window layout and styling
        general {
            gaps_in = 5
            gaps_out = 10
            border_size = 2
            col.active_border = rgba(33ccffee)
            col.inactive_border = rgba(595959aa)
            layout = dwindle
        }

        # Window decoration
        decoration {
            rounding = 10
            blur {
                enabled = true
                size = 3
                passes = 1
                new_optimizations = true
            }
            drop_shadow = true
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
        }

        # Animations
        animations {
            enabled = true
            bezier = myBezier, 0.05, 0.9, 0.1, 1.05
            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }

        # Layout rules
        dwindle {
            pseudotile = true
            preserve_split = true
        }

        # Keybindings
        $mainMod = SUPER

        # App bindings
        bind = $mainMod, Return, exec, $terminal
        bind = $mainMod, Q, killactive, 
        bind = $mainMod, M, exit, 
        bind = $mainMod, E, exec, $fileManager
        bind = $mainMod, V, togglefloating, 
        bind = $mainMod, R, exec, $menu
        bind = $mainMod, P, pseudo,
        bind = $mainMod, J, togglesplit,
        bind = $mainMod, L, exec, $locker
        bind = $mainMod, F, fullscreen
        
        # Screenshot
        bind = , Print, exec, grimblast copy area
        bind = SHIFT, Print, exec, grimblast save area

        # Move focus
        bind = $mainMod, h, movefocus, l
        bind = $mainMod, l, movefocus, r
        bind = $mainMod, k, movefocus, u
        bind = $mainMod, j, movefocus, d

        # Switch workspaces
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to workspace
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Mouse bindings
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        # Autostart
        exec-once = waybar
        exec-once = dunst
        exec-once = swww init
      '';
    };

    # Configure waybar
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = ["hyprland/workspaces" "hyprland/window"];
          modules-center = ["clock"];
          modules-right = ["pulseaudio" "network" "battery" "tray"];
          
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "urgent" = "";
              "active" = "";
              "default" = "";
            };
          };
          
          "clock" = {
            format = "{:%H:%M}";
            format-alt = "{:%Y-%m-%d}";
          };
          
          "battery" = {
            format = "{capacity}% {icon}";
            format-icons = ["" "" "" "" ""];
          };
          
          "network" = {
            format-wifi = "{essid} ";
            format-ethernet = "Connected ";
            format-disconnected = "Disconnected ⚠";
          };
          
          "pulseaudio" = {
            format = "{volume}% {icon}";
            format-muted = "Muted ";
            format-icons = {
              default = ["" ""];
            };
          };
        };
      };
      
      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font";
          font-size: 13px;
        }

        window#waybar {
          background-color: rgba(43, 48, 59, 0.8);
          color: #ffffff;
        }

        #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #ffffff;
        }

        #workspaces button.active {
          background-color: #64727D;
          border-bottom: 3px solid #ffffff;
        }

        #clock, #battery, #network, #pulseaudio, #tray {
          padding: 0 10px;
        }
      '';
    };

    # Wofi config
    programs.wofi = {
      enable = true;
      style = ''
        window {
          margin: 5px;
          border: 2px solid #33ccff;
          background-color: rgba(40, 42, 54, 0.9);
          border-radius: 10px;
        }

        #input {
          margin: 5px;
          border-radius: 5px;
          background-color: rgba(55, 59, 65, 0.95);
        }

        #entry:selected {
          background-color: #33ccff;
          color: #282a36;
          border-radius: 5px;
        }
      '';
    };
  };
}
