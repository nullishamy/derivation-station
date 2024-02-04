{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  system = import ../../users/amy/config.nix;
in {
  imports = [
    ./hardware.nix

    ../../users/amy
    ../common

    ./security.nix
    (import ./packages.nix {
      inherit system;
      inherit pkgs;
    })
    ./net.nix
    ./ui.nix
    ./audio.nix
  ];

  nixpkgs.overlays = [(import ../../users/${system.currentUser}/overlays)];

  # Enable non-free packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixpkgs-unstable> {
        inherit (config.nixpkgs) config;
      };
    };
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Configure nix itself
  nix = let
    flakeInputs = lib.filterAttrs (name: value: (value ? outputs) && (name != "self")) inputs;
  in {
    # Enable nix flakes
    package = pkgs.nixFlakes;

    # Automatically run the garbage collector
    gc.automatic = true;
    gc.dates = "12:45";

    # Automatically run the nix store optimiser
    optimise.automatic = true;
    optimise.dates = ["12:55"];

    settings = {
      # Nix automatically detects files in the store that have identical contents, and replaces them with hard links to a single copy.
      auto-optimise-store = true;

      # Maximum number of concurrent tasks during one build
      build-cores = 16;

      # Maximum number of jobs that Nix will try to build in parallel
      max-jobs = "auto";

      # Perform builds in a sandboxed environment
      sandbox = true;

      # Enable flakes
      experimental-features = ["nix-command" "flakes" "repl-flake"];

      # Consider downloaded tarballs as fresh for 7 days
      tarball-ttl = 604800;
    };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
    ];

    registry = builtins.mapAttrs (name: v: {flake = v;}) flakeInputs;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [pkgs.gutenprint pkgs.hplip];
  };

  # Add myself to additional groups
  users.extraGroups.docker.members = ["${system.currentUser}"];

  # Enable dockerd at the system level
  virtualisation.docker = {
    enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    # Only use the given nerdfonts, saves cloning *everything*
    (nerdfonts.override {fonts = ["Hack" "Iosevka" "FantasqueSansMono" "VictorMono" "NerdFontsSymbolsOnly"];})
  ];

  environment = {
    # Add zsh to /etc/shells
    shells = [
      pkgs.zsh
    ];

    pathsToLink = ["/share/zsh"];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
