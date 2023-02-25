{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./dedicated
    ./personal
    ./service
    ./system
    ./tools
    ./ui
  ];

  home.packages = with pkgs; [
    bottom
    neofetch
    gh
    thunderbird
    rofi
    spotifywm
    flameshot
    lazygit
    keybase
    neovide
    discord
    discord-canary
    bitwarden
    gparted
    gimp
    steam
    lunar-client
    pavucontrol
    deluge
    realvnc-vnc-viewer
    notion-app-enhanced
    photoqt
    dunst
    xdotool

    # 3D printing
    super-slicer

    # Modern unix
    ripgrep
    mcfly
    fd
    duf
    lsd
    bat
    jq
    tldr
    dogdns
    gitoxide

    jetbrains.idea-community
  ];
}
