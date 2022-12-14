{ config
, pkgs
, ...
}: {
  imports = [
  ];

  users.users.amy = {
    isNormalUser = true;
    description = "Amy Erskine";
    extraGroups = [
      "networkmanager" # Use networks
      "wheel" # Sudoer
      "docker"
      "lxd" # Use docker without root
      "vboxusers" # Virtualbox 
    ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  # CRON jobs
  services.cron = {
    enable = true;
    systemCronJobs = [
      "25 20 * * *   amy   . /etc/profile; ${./apps/dedicated/backup/run-backup.py} ${builtins.readFile ./apps/dedicated/backup/args.txt}"
    ];
  };

  home-manager.users.amy = {
    imports = [
      ./config.nix
    ];

    home = {
      inherit (config.system) stateVersion;

      username = "amy";
      homeDirectory = "/home/amy";
    };
  };
}
