{
  pkgs,
  system,
  ...
}: let
  rescrobbled = pkgs.callPackage ../../users/${system.currentUser}/packages/rescrobbled {};
in {
  imports = [../../users/${system.currentUser}/apps/personal/steam.nix];

  environment.systemPackages = with pkgs; [
    wget
    wezterm
    polybar
    chromium
    git
    redshift
    home-manager
    pipewire
    wireplumber
    pulseaudio
    zsh
    dconf
    fontconfig
    unzip
    gnupg
    pinentry-gtk2
    ntfsprogs
    yubico-pam
    yubikey-manager-qt
    xclip
    yubioath-flutter
    i3lock
    nano
    vim
  ];

  systemd.user.services.rescrobbled = {
    enable = true;
    description = "An MPRIS scrobbler";
    wantedBy = ["default.target"];
    environment = {
      DISPLAY = ":0";
    };
    serviceConfig = {
      ExecStart = "${rescrobbled}/bin/rescrobbled";
    };
  };

  services.ratbagd.enable = true;
}
