{
  config,
  pkgs,
  flakePath,
  system,
  ...
}: let
  mkSource = path: config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/${system.currentUser}/apps/dedicated/${path}";
in {
  config.home.file."etc/patches/patch-discord.sh" = {source = ./patch-discord.sh;};

  config.home = {
    sessionPath = ["${config.xdg.configHome}/emacs/bin"];
    sessionVariables = {
      DOOMDIR = "${config.xdg.configHome}/doom-config";
      DOOMLOCALDIR = "${config.xdg.configHome}/doom-local";
      DOOMPROFILELOADFILE = "${config.xdg.configHome}/doom-local/profiles.el";
    };
  };

  # Start the daemon
  config.services.emacs = {
    enable = true;
  };

  config.xdg.configFile = {
    "nvim" = {
      source = mkSource "nvim-config";
    };
    "wezterm" = {
      source = mkSource "wezterm-config";
    };
    "doom-config" = {
      source = mkSource "emacs-config";
    };
    "emacs" = {
      source = pkgs.fetchFromGitHub {
        repo = "doomemacs";
        owner = "doomemacs";
        rev = "e96624926d724aff98e862221422cd7124a99c19";
        sha256 = "sha256-C+mQGq/HBDgRkqdwYE/LB3wQd3oIbTQfzldtuhmKVeU=";
      };
      onChange = "${pkgs.writeShellScript "doom-change" ''
        export DOOMDIR="${config.home.sessionVariables.DOOMDIR}"
        export DOOMLOCALDIR="${config.home.sessionVariables.DOOMLOCALDIR}"
        export EMACS="${pkgs.emacs}"
        if [ ! -d "$DOOMLOCALDIR" ]; then
          ${config.xdg.configHome}/emacs/bin/doom -y install
        else
          ${config.xdg.configHome}/emacs/bin/doom -y sync -u
        fi
      ''}";
    };
  };
}
