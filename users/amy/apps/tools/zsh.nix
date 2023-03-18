# ZSH settings
{
  config,
  lib,
  pkgs,
  flakePath,
  system,
  ...
}: {
  programs = {
    bat.enable = true;

    btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };

    direnv.enable = true;
    direnv.nix-direnv.enable = true;

    fzf.enable = true;

    lsd = {
      enable = true;
      enableAliases = true;
    };

    mcfly = {
      enable = true;
      fuzzySearchFactor = 3;
    };

    # Support command-not-found in zsh
    nix-index.enable = true;

    starship = {
      enable = true;
    };

    tealdeer = {
      enable = true;
      settings = {
        updates = {
          auto_update = true;
        };
        display = {
          compact = false;
        };
        style = {
          command_name = {
            foreground = "red";
            bold = false;
          };
          example_text = {
            foreground = "green";
            bold = false;
          };
          example_code = {
            foreground = "blue";
            bold = false;
          };
          example_variable = {
            foreground = "blue";
            underline = false;
            bold = false;
          };
        };
      };
    };
  };

  xdg.configFile = let
    symlink = fileName: {recursive ? false}: {
      source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/${fileName}";
      inherit recursive;
    };
  in {
    "starship.toml" = symlink "users/${system.currentUser}/apps/tools/starship.toml" {};
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # Intentionally doesnt use the full path
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";

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
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];

    # Aliases
    shellAliases = {
      py = "python";
      nv = "neovide";
      lg = "lazygit";

      nix-clean = "cd ${flakePath} && just clean";
      nix-switch = "cd ${flakePath} && just switch";
      nix-update = "cd ${flakePath} && just upgrade";
      secret-reload = "echo 'Tap the YubiKey now:' && systemctl --user restart sops-nix && ssh-add ~/.ssh/github && echo 'Added Git SSH keys.'";

      # ;true swallows any additional args, instead of echoing them out with our echo
      nix-env = "echo 'do not the nix-env. https://stop-using-nix-env.privatevoid.net'; true";

      sxhkd-switch = "pkill -usr1 -x sxhkd";
      bspwm-switch = "bspc wm --restart";
      wallpaper-switch = "bash ${../../wallpapers}/sh/random-switch.sh";

      mkcd = "mkdir \"$1\" && cd \"$1\"";
      wget = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";

      # Modern unix
      grep = "rg $@";
      find = "fd $@";
      df = "duf $@";
      cat = "bat $@";
      dig = "dog $@";
    };

    # OMZ Config
    oh-my-zsh = {
      enable = true;
      theme = "philips";
      plugins = [
        "git"
        "ssh-agent"
      ];
    };

    envExtra = ''
      export MCFLY_KEY_SCHEME=vim
      export MCFLY_DISABLE_MENU=TRUE
    '';

    initExtra = ''
      # Little helper because doing the spawning in ZSH causes many issues
      # also we use "bash-isms" in the script
      function shell { bash ~/shells/spawn-shell.sh $@; }

      mkdir -p "$(dirname "$HISTFILE")"

      eval "$(mcfly init zsh)"
    '';
  };
}
