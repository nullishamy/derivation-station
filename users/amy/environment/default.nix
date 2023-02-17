{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    ALTERNATE_EDITOR = "";
    # "-a" will launch emacs if the dameon is dead
    EDITOR = "nvim";
    GIT_EDITOR = "nvim";
    VISUAL = "neovide";
    TERMINAL = "wezterm";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };

  home.file = {
    ".icons/default" = {source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ-AA";};
  };
}
