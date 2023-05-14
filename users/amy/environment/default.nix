{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./gpg.nix
  ];
  config.home.sessionVariables = {
    ALTERNATE_EDITOR = "";
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

  # Declared here as it is only relevant to the remapping ^^
  config.programs.go = {
    enable = true;
    goPath = "${config.xdg.dataHome}/go";
  };

  config.xdg.dataFile = {
    "icons/default" = {source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ-AA";};
  };
}
