{ config, pkgs, ... }: {
  home.sessionVariables = {
    ALTERNATE_EDITOR="";
    # "-a" will launch emacs if the dameon is dead
    EDITOR="emacsclient -t";
    GIT_EDITOR = "emacsclient -t";
    VISUAL="emacsclient -c -a emacs";
    TERMINAL = "wezterm";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };

  home.file = {
    ".icons/default" = { source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ-AA"; };
  };
}
