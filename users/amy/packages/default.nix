{ config, pkgs, ... }: {
  config.home.packages = [ 
    # (pkgs.callPackage ./cargo { })
    (pkgs.callPackage ./catppuccin-gtk { })
    (pkgs.callPackage ./nvim { })
  ];
}
