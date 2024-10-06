{
  config,
  lib,
  pkgs,
  flakePath,
  system,
  ...
}: {
  imports = [
    ./zsh.nix
    ./nu
  ];

  programs.atuin = {
    enable = true;
    flags = ["--disable-up-arrow"];
    package = pkgs.unstable.atuin;
    settings = {
      dialect = "uk";
      show_help = false;
    };
  };

  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
}
