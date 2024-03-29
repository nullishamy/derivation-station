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
    _1password-gui
    gparted
    gimp
    steam
    lunar-client
    pavucontrol
    photoqt
    dunst

    # 3D printing
    super-slicer

    # Modern unix
    ripgrep
    fd
    duf
    jq
    dogdns

    jetbrains.idea-community
  ];
}
