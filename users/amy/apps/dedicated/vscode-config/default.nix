{
  config,
  flakePath,
  lib,
  pkgs,
  nix-vscode-extensions,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    extensions = (import ./packages.nix) {
      inherit pkgs;
      inherit lib;
      inherit nix-vscode-extensions;
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

  # Snippet for when we need to use the home-manager unstable vscode module
  # disabledModules = ["programs/vscode"];
  # imports = [
  #   "${inputs.home-manager-unstable.outPath}/modules/programs/vscode.nix"
  # ];
}
