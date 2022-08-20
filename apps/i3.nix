# i3 settings

{ config, lib, pkgs, ...}:

let
  mod = config.xsession.windowManager.i3.config.modifier;
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      colors = {
        background = "#000000";

        focused = {
          background = "#2B313B"; 
          border = "#363D4A"; 
          childBorder = "#363D4A"; 
          indicator = "#363D4A"; 
          text = "#FFFFFF";
        };

        focusedInactive = {
          background = "#2B313B"; 
          border = "#363D4A"; 
          childBorder = "#363D4A"; 
          indicator = "#363D4A"; 
          text = "#FFFFFF";
        };

        unfocused = {
          background = "#2B313B"; 
          border = "#2B313B"; 
          childBorder = "#2B313B"; 
          indicator = "#2B313B"; 
          text = "#FFFFFF";
        };

        urgent = {
          background = "#AD34C4"; 
          border = "#AD34C4"; 
          childBorder = "#AD34C4"; 
          indicator = "#AD34C4"; 
          text = "#FFFFFF";
        };

        placeholder = {
          background = "#000000"; 
          border = "#000000"; 
          childBorder = "#000000"; 
          indicator = "#000000"; 
          text = "#FFFFFF";
        };
      };

      fonts = {
        names = [ "Hack Nerd Font "];
        size = 8.0;
      };

      gaps = {
       inner = 10;
       right = 5;
       left = 5;
      };

      # Set our menu to rofi, replaces dmenu
      menu = "rofi -show run -no-lazy-grab -lines 15 -width 40";
      terminal = "alacritty";

      # Ask home-manager to supply the defaults so we dont needlessly specify them
      keybindings = lib.mkOptionDefault {
        "${mod}+Right" = "resize shrink width 10 px or 10 ppt";
        "${mod}+Up" = "resize grow height 10 px or 10 ppt";
        "${mod}+Down" = "resize shrink height 10 px or 10 ppt";
        "${mod}+Left" = "resize grow width 10 px or 10 ppt";
        "Print" = "exec flameshot gui";
      };

      startup = [ 
        { command = "nm-applet"; }
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        { command = "polybar -r top"; }
        { command = "flameshot"; }
        { command = "xrandr --output HDMI-A-1 --mode 1920x1080 --rate 144 --primary"; }
        { command = "redshift -P -O 2500"; }
        { command = "discord"; }
        # Launch spotifywm instead, which has WM bug fixes (https://github.com/dasJ/spotifywm)
        { command = "spotifywm"; }
      ];

      # Remove the default bar
      bars = [ ];

      workspaceAutoBackAndForth = true;
    };

    # Remove borders and add automatic window moving
    extraConfig = ''
        for_window [class=".*"] border pixel 1
        default_border pixel 1

        
        for_window [class="Spotify"] move to workspace 2,
        for_window [class="discord"] move to workspace 3,
    '';
  };
}
