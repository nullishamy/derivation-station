{ pkgs, ... }:

{
  services.picom = {
    enable = true;

    settings = {
      # -- SHADOWS --
      shadow = false;
      shadow-radius = 2;
      shadow-opacity = .75;
      shadow-offset-x = -2;
      shadow-offset-y = -2;
      shadow-exclude = [ ];

      # -- FADING --
      fading = false;
      fade-in-step = 0.03;
      fade-out-step = 0.03;
      fade-delta = 5;
      fade-exclude = [ ];
      no-fading-openclose = 1;

      # -- TRANSPARENCY / OPACITY --
      inactive-opacity = 1;
      frame-opacity = 1;
      inactive-opacity-override = false;
      active-opacity = 1;
      inactive-dim = 0;
      focus-exclude = [ ];
      # inactive-dim-fixed = 1.0;
      opacity-rule = [ ];

      # -- CORNERS --
      corner-radius = 10;
      round-borders = 1;
      rounded-corners-exclude = [ ];

      # -- GENERAL --
      backend = "glx";
      glx-no-rebind-pixmap = 1;
    };
  };

  # Configure X11
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";

    windowManager.bspwm = {
      enable = true;
    };

    displayManager = {
      defaultSession = "none+bspwm";
    };

    desktopManager = {
      wallpaper = {
        mode = "center";
      };
    };

    xautolock = {
      enable = true;

      # Time, in minutes, before the screen automatically locks
      time = 60;

      # The command to run when locking
      locker = "${pkgs.i3lock}/bin/i3lock -c 282828";
      nowlocker = "${pkgs.i3lock}/bin/i3lock -c 282828";
    };
  };
}
