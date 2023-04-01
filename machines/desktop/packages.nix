{
  pkgs,
  system,
  ...
}: {
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
    yubioath-desktop
    i3lock
    nano
    vim
  ];

  services.ratbagd.enable = true;
}
