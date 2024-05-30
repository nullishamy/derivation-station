{
  symlinkJoin,
  emacs,
  makeDesktopItem,
  ...
}: let
  name = "emacs";
  meta = emacs.meta;

  desktopItem = makeDesktopItem {
    inherit name;
    exec = name;
    desktopName = "Emacs";
    genericName = "Text Editor";
    categories = ["TextEditor"];
    startupNotify = true;
  };
in
  symlinkJoin {
    inherit name meta;
    paths = [
      emacs
      desktopItem
    ];
  }
