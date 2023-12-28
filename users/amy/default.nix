{
  config,
  pkgs,
  ...
}: let
  system = import ./config.nix;
in {
  imports = [
  ];

  users.users.${system.currentUser} = {
    isNormalUser = true;
    description = system.userName;
    hashedPassword = "$6$EuVxrglUIHa0ojiz$Oy9JF.PIAmsb.5Vz9icDwbpPp0Mw5ct3aOAniJ0n/s7.3ZGNQfiC4izz/Uc6FdgmPg9UWtoqGWo3mX6";
    extraGroups = [
      "networkmanager" # Use networks
      "wheel" # Sudoer
      "docker"
      "lxd"
      "vboxusers" # Virtualbox
    ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  home-manager.users.${system.currentUser} = {
    imports = [
      ./packages
      ./environment
      ./apps
      ./shells
      ./wallpapers
    ];

    home = {
      inherit (config.system) stateVersion;

      username = system.currentUser;
      homeDirectory = "/home/${system.currentUser}";
    };
  };
}
