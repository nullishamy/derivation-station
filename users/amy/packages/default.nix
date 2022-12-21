{ config, pkgs, ... }: {
  config.home.packages = [ 
    # FIXME: Fix this
    # (pkgs.callPackage ./cargo { })
    (pkgs.callPackage ./catppuccin-gtk { })
    (pkgs.callPackage ./nvim { })
  ];
}
