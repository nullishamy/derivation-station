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
    description = "Amy";
    hashedPassword = "$6$EuVxrglUIHa0ojiz$Oy9JF.PIAmsb.5Vz9icDwbpPp0Mw5ct3aOAniJ0n/s7.3ZGNQfiC4izz/Uc6FdgmPg9UWtoqGWo3mX6";
    extraGroups = [
      "networkmanager" # Use networks
      "wheel" # Sudoer
      "docker"
      "lxd" # Use docker without root
      "vboxusers" # Virtualbox
    ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # VM user
  users.users.nixosvmtest.isSystemUser = true;
  users.users.nixosvmtest.initialPassword = "test";
  users.users.nixosvmtest.group = "nixosvmtest";
  users.groups.nixosvmtest = {};

  # VM settings
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8064;
      cores = 8;
    };
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
