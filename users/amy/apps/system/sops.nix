{config, ...}: {
  sops = {
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    defaultSopsFile = ../../../../secrets.yaml;
    secrets = {
      "ssh-private-key" = {
        path = "${config.home.homeDirectory}/.ssh/github";
      };
      "ssh-public-key" = {
        path = "${config.home.homeDirectory}/.ssh/github.pub";
      };
    };
  };
}
