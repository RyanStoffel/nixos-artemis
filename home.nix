{ config, pkgs, inputs, ... }:
{
  # user settings
  home.username = "rstoffel";
  home.homeDirectory = "/home/rstoffel";
  home.stateVersion = "23.11";

  # packages
  home.packages = with pkgs; [
    # shell
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    
    # utilities
    zip
    unzip
    wl-clipboard
    
    # applications
    inputs.zen-browser.packages.${pkgs.system}.default
    kitty
    alacritty
    wofi
    waybar
    dunst
    firefox
    swww
    
    # theme and styling
    nordic
    papirus-icon-theme
  ];

  # programs
  programs.starship.enable = true;
  programs.home-manager.enable = true;

  # gtk theme
  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # hyprland window manager
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # monitor configuration
      monitor = "DP-2,preferred,auto,auto";
      
      # input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0;
      };
      
      # general configuration
      general = {
        gaps_in = 8;
        gaps_out = 16;
        border_size = 2;
        "col.active_border" = "rgba(88c0d0ff) rgba(5e81acff) 45deg";
        "col.inactive_border" = "rgba(3b4252aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      # decoration
      decoration = {
        rounding = 12;
        blur = {
          enabled = true;
          size = 6;
          passes = 2;
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 12;
        shadow_render_power = 3;
        "col.shadow" = "rgba(000000aa)";
      };
      
      # animations
      animations = {
        enabled = true;
        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];
        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };
      
      # layout configuration
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      
      # window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "opacity 0.95 0.95,class:^(kitty)$"
        "opacity 0.95 0.95,class:^(Alacritty)$"
        "opacity 0.98 0.98,class:^(Code)$"
        "opacity 0.98 0.98,class:^(firefox)$"
        "opacity 1.0 1.0,class:^(steam)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(blueman-manager)$"
        "float,class:^(nm-connection-editor)$"
      ];
      
      # key bindings
      "$mod" = "SUPER";
      
      bind = [
        # Application launches (organized by category)
        # Terminals
        "$mod, T, exec, kitty"
        "$mod SHIFT, T, exec, alacritty"
        
        # Browsers
        "$mod, B, exec, zen"
        "$mod SHIFT, B, exec, firefox"
        "$mod CTRL, B, exec, google-chrome-stable"
        "$mod ALT, B, exec, firefox-devedition"
        
        # Code Editors
        "$mod, C, exec, code"
        "$mod SHIFT, C, exec, zed"
        
        # Communication
        "$mod, S, exec, slack"
        "$mod, D, exec, discord"
        "$mod, M, exec, thunderbird"
        
        # Productivity
        "$mod, O, exec, obsidian"
        "$mod, P, exec, postman"
        "$mod, 1, exec, 1password"
        
        # Media & Entertainment
        "$mod, A, exec, spotify"
        "$mod, V, exec, vlc"
        "$mod, G, exec, steam"
        
        # File Management
        "$mod, E, exec, thunar"
        
        # System
        "$mod, space, exec, wofi --show drun"
        "$mod, Q, killactive"
        "$mod SHIFT, Q, exec, hyprctl kill"
        "$mod ALT, Q, exit"
        "$mod, F, togglefloating"
        "$mod, R, exec, wofi --show run"
        "$mod, J, togglesplit"
        "$mod SHIFT, F, fullscreen"
        
        # Window management
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        
        # Move windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        
        # Resize windows
        "$mod CTRL, left, resizeactive, -20 0"
        "$mod CTRL, right, resizeactive, 20 0"
        "$mod CTRL, up, resizeactive, 0 -20"
        "$mod CTRL, down, resizeactive, 0 20"
        
        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        
        # Move to workspace
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        
        # Special workspace (scratchpad)
        "$mod, grave, togglespecialworkspace, magic"
        "$mod SHIFT, grave, movetoworkspace, special:magic"
        
        # Media keys
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
        
        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, Print, exec, grim - | wl-copy"
        
        # Quick system controls
        "$mod SHIFT, R, exec, hyprctl reload"
        "$mod CTRL, L, exec, swaylock"
      ];
      
      # Mouse bindings
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      
      # Startup applications
      exec-once = [
        "waybar &"
        "dunst &"
        "swww-daemon &"
        "sleep 2 && swww img ~/Pictures/wallpaper2.jpg &"
        "1password --silent &"
        "nm-applet &"
        "blueman-applet &"
        "spotify &"
        "discord &"
        "slack &"
      ];
    };
  };

  # Wofi configuration - Raycast-like dark theme
  home.file.".config/wofi/config".text = ''
    width=800
    height=600
    location=center
    show=drun
    prompt=Search...
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    content_halign=fill
    insensitive=true
    allow_images=true
    image_size=24
    gtk_dark=true
    sort_order=alphabetical
    matching=contains
  '';

  home.file.".config/wofi/style.css".text = ''
    * {
      all: unset;
      font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
    }

    #window {
      margin: 0px;
      border: 2px solid #5e81ac;
      background-color: rgba(46, 52, 64, 0.95);
      border-radius: 15px;
      box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.5);
    }

    #input {
      all: unset;
      margin: 15px;
      border: none;
      color: #eceff4;
      background-color: rgba(59, 66, 82, 0.8);
      border-radius: 10px;
      padding: 15px 20px;
      font-size: 16px;
      box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.2);
    }

    #input:focus {
      background-color: rgba(67, 76, 94, 0.95);
      border: 1px solid #88c0d0;
    }

    #inner-box {
      margin: 5px;
      border: none;
      background-color: transparent;
    }

    #outer-box {
      margin: 5px;
      border: none;
      background-color: transparent;
    }

    #scroll {
      margin-top: 5px;
      border: none;
      border-radius: 10px;
    }

    #text {
      margin: 5px;
      border: none;
      color: #eceff4;
      font-size: 14px;
    }

    #entry {
      background-color: transparent;
      color: #eceff4;
      border: none;
      border-radius: 8px;
      margin: 2px 8px;
      padding: 10px 15px;
      transition: all 0.2s ease;
    }

    #entry:selected {
      background-color: rgba(136, 192, 208, 0.2);
      color: #88c0d0;
      border: 1px solid rgba(136, 192, 208, 0.4);
      box-shadow: 0px 2px 8px rgba(136, 192, 208, 0.1);
    }

    #entry:hover {
      background-color: rgba(136, 192, 208, 0.1);
    }

    #entry img {
      border-radius: 6px;
      margin-right: 10px;
    }
  '';

  # Waybar configuration - KDE Plasma-like bottom taskbar
  home.file.".config/waybar/config".text = ''
    {
      "layer": "top",
      "position": "bottom",
      "height": 48,
      "spacing": 4,
      "modules-left": ["custom/launcher", "hyprland/workspaces", "hyprland/window"],
      "modules-center": ["custom/apps"],
      "modules-right": ["tray", "bluetooth", "network", "pulseaudio", "clock", "custom/notification"],
      
      "custom/launcher": {
        "format": "󰣇",
        "on-click": "wofi --show drun",
        "tooltip": false
      },
      
      "hyprland/workspaces": {
        "disable-scroll": true,
        "all-outputs": true,
        "format": "{icon}",
        "format-icons": {
          "1": "1",
          "2": "2", 
          "3": "3",
          "4": "4",
          "5": "5",
          "6": "6",
          "7": "7",
          "8": "8",
          "9": "9",
          "10": "10"
        }
      },
      
      "hyprland/window": {
        "format": "{title}",
        "max-length": 50,
        "separate-outputs": true
      },
      
      "custom/apps": {
        "format": "{}",
        "exec": "echo '    󰈹    󰊻       󰙯    󰓇'",
        "interval": "once",
        "on-click": "",
        "tooltip": false
      },
      
      "tray": {
        "icon-size": 18,
        "spacing": 8
      },
      
      "bluetooth": {
        "format": " {status}",
        "format-connected": " {device_alias}",
        "format-connected-battery": " {device_alias} {device_battery_percentage}%",
        "tooltip-format": "{controller_alias}\t{controller_address}\n\n{num_connections} connected",
        "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}",
        "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
        "tooltip-format-enumerate-connected-battery": "{device_alias}\t{device_address}\t{device_battery_percentage}%",
        "on-click": "blueman-manager"
      },
      
      "network": {
        "format-wifi": "  {signalStrength}%",
        "format-ethernet": " ",
        "tooltip-format": "{ifname} via {gwaddr}",
        "format-linked": "{ifname} (No IP)",
        "format-disconnected": "⚠ ",
        "format-alt": "{ifname}: {ipaddr}/{cidr}",
        "on-click": "nm-connection-editor"
      },
      
      "pulseaudio": {
        "format": "{icon} {volume}%",
        "format-bluetooth": "{icon} {volume}% ",
        "format-bluetooth-muted": " {icon}",
        "format-muted": " ",
        "format-source": " {volume}%",
        "format-source-muted": "",
        "format-icons": {
          "headphone": "",
          "hands-free": "",
          "headset": "",
          "phone": "",
          "portable": "",
          "car": "",
          "default": ["", "", ""]
        },
        "on-click": "pavucontrol"
      },
      
      "clock": {
        "timezone": "America/Los_Angeles",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format": "{:%a %b %d  %I:%M %p}",
        "format-alt": "{:%Y-%m-%d}"
      },
      
      "custom/notification": {
        "tooltip": false,
        "format": "{icon}",
        "format-icons": {
          "notification": "<span foreground='red'><sup></sup></span>",
          "none": "",
          "dnd-notification": "<span foreground='red'><sup></sup></span>",
          "dnd-none": "",
          "inhibited-notification": "<span foreground='red'><sup></sup></span>",
          "inhibited-none": "",
          "dnd-inhibited-notification": "<span foreground='red'><sup></sup></span>",
          "dnd-inhibited-none": ""
        },
        "return-type": "json",
        "exec-if": "which swaync-client",
        "exec": "swaync-client -swb",
        "on-click": "swaync-client -t -sw",
        "on-click-right": "swaync-client -d -sw",
        "escape": true
      }
    }
  '';

  home.file.".config/waybar/style.css".text = ''
    * {
      border: none;
      border-radius: 0;
      font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
      font-size: 13px;
      min-height: 0;
    }

    window#waybar {
      background-color: rgba(46, 52, 64, 0.95);
      border-top: 2px solid #5e81ac;
      color: #eceff4;
      transition-property: background-color;
      transition-duration: 0.5s;
    }

    window#waybar.hidden {
      opacity: 0.2;
    }

    #workspaces button {
      padding: 0 8px;
      background-color: transparent;
      color: #d8dee9;
      border-radius: 6px;
      margin: 4px 2px;
      transition: all 0.2s ease;
    }

    #workspaces button:hover {
      background: rgba(136, 192, 208, 0.2);
      color: #88c0d0;
    }

    #workspaces button.active {
      background-color: #5e81ac;
      color: #eceff4;
      box-shadow: 0 2px 8px rgba(94, 129, 172, 0.3);
    }

    #workspaces button.urgent {
      background-color: #bf616a;
      color: #eceff4;
    }

    #custom-launcher {
      font-size: 18px;
      color: #88c0d0;
      background-color: rgba(136, 192, 208, 0.15);
      padding: 8px 12px;
      margin: 4px 8px 4px 4px;
      border-radius: 8px;
      transition: all 0.2s ease;
    }

    #custom-launcher:hover {
      background-color: rgba(136, 192, 208, 0.25);
      color: #5e81ac;
    }

    #window {
      margin: 4px 8px;
      padding: 8px 12px;
      border-radius: 8px;
      background-color: rgba(59, 66, 82, 0.5);
      color: #d8dee9;
      font-weight: 500;
    }

    #custom-apps {
      font-size: 16px;
      color: #d8dee9;
      background-color: rgba(59, 66, 82, 0.3);
      padding: 8px 16px;
      margin: 4px;
      border-radius: 8px;
    }

    #tray,
    #bluetooth,
    #network,
    #pulseaudio,
    #clock,
    #custom-notification {  
      padding: 8px 12px;
      margin: 4px 2px;
      color: #eceff4;
      border-radius: 8px;
      background-color: rgba(59, 66, 82, 0.4);
    }

    #bluetooth {
      color: #88c0d0;
    }

    #network {
      color: #a3be8c;
    }

    #pulseaudio {
      color: #ebcb8b;
    }

    #clock {
      color: #b48ead;
      font-weight: 600;
      margin-right: 4px;
    }

    #custom-notification {
      color: #bf616a;
    }

    tooltip {
      background: rgba(46, 52, 64, 0.95);
      border: 2px solid #5e81ac;
      border-radius: 10px;
      color: #eceff4;
    }
  '';
}
