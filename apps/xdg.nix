# XDG settings

{ config, lib, pkgs, ...}:

{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;

      # Improve the XDG dir locations so they dont clutter up $HOME
      download    = ~/downloads;
      desktop     = ~/desktop;
      documents   = ~/documents;

      publicShare = ~/etc/public;
      templates   = ~/etc/templates;

      music       = ~/media/music;
      pictures    = ~/media/pictures;
      videos      = ~/media/videos;
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["chromium.desktop"];
        "image/png" = ["photoqt.desktop"];
        "text/plain" = ["neovide.desktop"];
      };
    };
  };
}
