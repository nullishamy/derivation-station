# ZSH settings

{ config, lib, pkgs, ...}:

{
  programs.zsh = {
      enable = true;
      enableCompletion = true;

      # OMZ Plugins
      plugins = [
          {
            name = "zsh-autosuggestions";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-autosuggestions";
              rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
              sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
            };
          }
          {
            name = "zsh-syntax-highlighting";
            src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-syntax-highlighting";
              rev = "caa749d030d22168445c4cb97befd406d2828db0";
              sha256 = "17ck9lm8j6bv9fhag827kxrbwdwbhhss0sw7p1yz7nhpknj6apv1";
            };
          }
      ];
  
      # Aliases
      shellAliases = {
        py = "python";
        nv = "neovide";
        lg = "lazygit";
      };

      # OMZ Config
      oh-my-zsh = {
        enable = true;
        theme = "philips";
        plugins = [
          "git"
        ];
      };

      initExtra = ''
        function shell () {
          nix-shell ~/shells/$1.nix
        }
      '';
    };
}
