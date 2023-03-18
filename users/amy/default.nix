{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  users.users.amy = {
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

  # CRON jobs
  services.cron = {
    enable = false;
    systemCronJobs = [
      "25 20 * * *   amy   . /etc/profile; ${./apps/dedicated/backup/run-backup.py} ${builtins.readFile ./apps/dedicated/backup/args.txt}"
    ];
  };

  home-manager.users.amy = {
    imports = [
      ./packages
      ./environment
      ./apps
      ./shells
      ./wallpapers
    ];

    home = {
      inherit (config.system) stateVersion;

      username = "amy";
      homeDirectory = "/home/amy";
    };
  };
}
