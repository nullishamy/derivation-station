{
  config,
  flakePath,
  lib,
  pkgs,
  ...
}: {
  programs.vscode = {
    enable = true;
    extensions = (import ./packages.nix) {
      inherit pkgs;
      inherit lib;
    };
    mutableExtensionsDir = true;
  };
  home.file = {
    "${config.xdg.configHome}/Code/User/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/dedicated/vscode-config/settings.json";
    };
    "${config.xdg.configHome}/Code/User/keybindings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/dedicated/vscode-config/keybindings.json";
    };
  };
}
