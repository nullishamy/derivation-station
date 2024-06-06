{config, ...}: {
  sops = {
    gnupg.home = config.programs.gpg.homedir;
    defaultSopsFile = ../../../../secrets.yaml;
    secrets = {
      "ssh-private-key" = {
        path = "${config.home.homeDirectory}/.ssh/github";
      };
      "ssh-public-key" = {
        path = "${config.home.homeDirectory}/.ssh/github.pub";
      };
      "emacs" = {
        path = "${config.xdg.configHome}/emacs/secrets.el";
      };
    };
  };
}
