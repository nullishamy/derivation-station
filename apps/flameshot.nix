# Flameshot settings

{ config, lib, pkgs, ...}:

let colors = [ 
    "#CC241D"
    "#98971A"
    "#D79921"
    "#D65D0E"
    "#458588"
    "#B16286"
    "#689D6A"
    "#A89984"
  ];
in {
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        showStartupLaunchMessage = false;
        predefinedColorPaletteLarge = true;
        showHelp = false;
        uiColor= "#282828";
        contrastUiColor="#458588";
        userColors = "picker,${builtins.concatStringsSep "," colors}";
        drawColor="#689D6A";
      };
    };
  };
}
