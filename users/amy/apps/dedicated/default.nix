{
  config,
  pkgs,
  flakePath,
  system,
  ...
}: let
  mkSource = path: config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/${system.currentUser}/apps/dedicated/${path}";
in {
  imports = [
    ./vscode-config
  ];

  config.home.file."etc/patches/patch-discord.sh" = {source = ./patch-discord.sh;};

  config.home = {
    sessionPath = ["${config.xdg.configHome}/emacs/bin"];
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
    "emacs" = {
      source = mkSource "emacs-config";
    };
  };
}
