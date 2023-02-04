# XDG settings

{ config, lib, pkgs, ...}:

{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;

      # Improve the XDG dir locations so they dont clutter up $HOME
      download    = "$HOME/downloads";
      desktop     = "$HOME/desktop";
      documents   = "$HOME/documents";

      publicShare = "$HOME/etc/public";
      templates   = "$HOME/etc/templates";

      music       = "$HOME/media/music";
      pictures    = "$HOME/media/pictures";
      videos      = "$HOME/media/videos";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["chromium.desktop"];
        "image/png" = ["photoqt.desktop"];
        "text/plain" = ["neovide.desktop"];

        # xdg-open for mail
        "x-scheme-handler/mailto" = ["thunderbird.desktop"];
        "x-scheme-handler/mid" = ["thunderbird.desktop"];
        "message/rfc822" = ["thunderbird.desktop"];
      };
    };
  };
}
