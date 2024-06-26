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
      "authinfo" = {
        path = "${config.home.homeDirectory}/.authinfo";
      };
      "emacs" = {
        path = "${config.xdg.configHome}/emacs/secrets.el";
      };
    };
  };
}
