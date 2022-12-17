{ config, pkgs, ... }: {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "neovide";
    GIT_EDITOR = "nvim";
    TERMINAL = "wezterm";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
  };

  home.file = {
    ".icons/default" = { source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ-AA"; };
  };
}
