{ pkgs, ... }:

{
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
    yubioath-flutter
    xclip
    i3lock
    nano
    vim
  ];
}
