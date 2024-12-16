{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./cargo
  ];

  config.home.packages = [
    (pkgs.callPackage ./catppuccin-gtk {})
    (pkgs.unstable.callPackage ./nvim {})
    (pkgs.callPackage ./emacs {
      emacs = with pkgs; (
        (emacsPackagesFor pkgs.unstable.emacs).emacsWithPackages (
          epkgs: [epkgs."treesit-grammars".with-all-grammars]
        )
      );
    })
    (pkgs.callPackage ./apple-music {})
    (pkgs.callPackage ./rescrobbled {})
  ];
}
