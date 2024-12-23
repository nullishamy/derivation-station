{
  config,
  lib,
  pkgs,
  flakePath,
  nu_scripts,
  ...
}: {
  programs.nushell = {
    enable = true;
    package = pkgs.unstable.nushell;
  };

  home.file = {
    "${config.xdg.configHome}/nushell/config.nu" = lib.mkForce {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/tools/nu/config.nu";
    };
    "${config.xdg.configHome}/nushell/env.nu" = lib.mkForce {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/tools/nu/env.nu";
    };
    "${config.xdg.configHome}/nushell/ls-colors" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/tools/nu/ls-colors";
    };
    "${config.xdg.configHome}/nushell/env-nix.nu" = with lib; let
      environmentVariables = {
        # "-a" will launch emacs if the dameon is dead
        EDITOR = "nvim";
        GIT_EDITOR = "nvim";
        VISUAL = "neovide";
        TERMINAL = "wezterm";

        CARGO_HOME = "${config.xdg.dataHome}/cargo";
        HISTFILE = "${config.xdg.dataHome}/history";
        GNUPGHOME = "${config.xdg.dataHome}/gnupg";
        GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
        GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc";
        XCURSOR_PATH = "/usr/share/icons:${config.xdg.dataHome}/icons";
        NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
        _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=\"${config.xdg.configHome}\"/java";
        PLATFORMIO_CORE_DIR = "${config.xdg.dataHome}/platformio";
        RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
        WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
        XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
        # XAUTHORITY = "${config.xdg.runtimeDir}/Xauthority";
      };
    in {
      text = ''
        ${concatStringsSep "\n"
          (mapAttrsToList (k: v: "$env.${k} = \"${v}\"")
            environmentVariables)}
      '';
    };
    "${config.xdg.configHome}/nushell/scripts" = {
      source = nu_scripts;
    };
  };
}
