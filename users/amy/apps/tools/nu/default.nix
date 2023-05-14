{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}: {
  programs.nushell = {
    enable = true;
    package = pkgs.unstable.nushell;
    configFile = {
      source = ./config.nu;
    };
  };

  home.file = {
    "${config.xdg.configHome}/nushell/config.nu" = lib.mkForce {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/tools/nu/config.nu";
    };
    "${config.xdg.configHome}/nushell/env.nu" = lib.mkForce {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/tools/nu/env.nu";
    };
    "${config.xdg.configHome}/nushell/scripts" = lib.mkForce {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/users/amy/apps/tools/nu/nu_scripts";
    };
  };
}
