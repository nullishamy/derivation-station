# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      <home-manager/nixos>

      # Apps
      ../apps/steam.nix
    ];

  boot.loader = {
    systemd-boot = {
      enable = true;
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  networking = {
    hostName = "nixon";

    networkmanager = {
      enable = true;
    };

    # proxy = {
    #   default = "";
    # 	noProxy = "";
    # };
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  # Configure keymap in X11
  services.xserver = {
    enable = true;

    layout = "us";
    xkbVariant = "";

    windowManager.i3 = {
     enable = true;
     package = pkgs.i3-gaps;
    
     extraPackages = with pkgs; [
       i3lock # Screen locker
     ];

   };

   xautolock = {
     enable = true;

     # Time, in minutes, before the screen automatically locks
     time = 60;

     # The command to run when locking
     locker = "${pkgs.i3lock}/bin/i3lock -c 282828";
     nowlocker = "${pkgs.i3lock}/bin/i3lock -c 282828";
   };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Configure console keymap
  console.keyMap = "us";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.amy = {
    isNormalUser = true;
    description = "Amy Erskine";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Pinentry / GPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
     enable = true;
     pinentryFlavor = "gtk2";
     enableSSHSupport = true;
  };

  # Increase open file limits
  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "8192";
  }];

  environment.pathsToLink = [ "/share/zsh" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "Iosevka" ]; })
  ];

  # Shell config
  environment.shells = [
    pkgs.zsh
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget alacritty
     i3-gaps polybar chromium git
     xclip redshift home-manager
     pipewire wireplumber pulseaudio
     clang zsh dconf fontconfig unzip
     gnupg pinentry-gtk2 

     # My wrappers
     (callPackage ../wrappers/nvim.nix {})
  ];

  # Home manager
  home-manager = {
    useGlobalPkgs = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
