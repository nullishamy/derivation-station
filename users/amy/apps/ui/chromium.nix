# Chromium settings
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.chromium = {
    enable = true;
    commandLineArgs = ["--force-dark-mode" "--enable-features=WebUIDarkMode"];
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # Dark Reader
      {id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa";} # 1Password
      {id = "mnjggcdmjocbbbhaepdhchncahnbgone";} # SponsorBlock
      {id = "hlepfoohegkhhmjieoechaddaejaokhf";} # Refined GitHub
      {id = "jehmdpemhgfgjblpkilmeoafmkhbckhi";} # ScrollAnywhere
      {id = "dhdgffkkebhmkfjojejmpbldmpobfkfo";} # TamperMonkey
    ];
  };
}
