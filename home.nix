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

  # Explicitly disable waybar and wofi program management
  # This prevents Home Manager from creating config symlinks
  programs.waybar.enable = false;
  programs.wofi.enable = false;

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
      monitor = "DP-2,3440x1440@180,0x0,1";
      
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
        "$mod SHIFT, 1, exec, 1password"
        
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
        "nm-applet &"
        "blueman-applet &"
      ];
    };
  };
}
