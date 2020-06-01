{ config, pkgs, ... }:

{
  imports = [
    ../fonts
    ../base
    ../base-desktop
  ];

  users.defaultUser = {
    name = "vasy";
    packages = with pkgs; [
      unzip
      zip
      unrar
      htop
      bat
      usbutils
      psmisc
      hicolor_icon_theme
      tig
      fzf
      nix-bash-completions
      aspell
      aspellDicts.en
      spotify
      feh
      zathura
      firefox
      chromium
      keepassxc
      libnotify
      _vim
      parsec-client

      (weechat.override {
        configure = { availablePlugins, ... }: {
          plugins = with availablePlugins; [
            (python.withPackages (_: with weechatScripts; [ weechat-matrix ]))
          ];

          scripts = with weechatScripts; [
            weechat-matrix
            wee-slack
          ];
        };
      })

    ];
  };

  networking.networkmanager = { dns = "dnsmasq"; };

  virtualisation.lxd.enable = true;

  programs = {
    sway = {
      enable = true;
      menu = "${pkgs.bemenu}/bin/bemenu-run -w -i --prefix '⇒' --prompt 'Run: ' --hb '#404654' --ff '#c698e3' --tf '#c698e3' --hf '#fcfcfc'";
    };

    tmux = {
      enable = true;
      shortcut = "Space";
    };

    bash = {
      interactiveShellInit = ''
        __fzf_history__() {
           local output
           output=$(
             builtin history -n
             builtin fc -lnr -2147483648 |
               last_hist=$(HISTTIMEFORMAT=''' builtin history 1) ${pkgs.perl}/bin/perl -n -l0 -e 'BEGIN { getc; $/ = "\n\t"; $HISTCMD = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCMD - $. . "\t$_" if !$seen{$_}++' |
               FZF_DEFAULT_OPTS="--height 30% $FZF_DEFAULT_OPTS -n2..,.. --reverse --tiebreak=index --bind=ctrl-r:toggle-sort +m --read0" ${pkgs.fzf}/bin/fzf --query "$READLINE_LINE"
           ) || return
           READLINE_LINE=''${output#*$'\t'}
           if [ -z "$READLINE_POINT" ]; then
             echo "$READLINE_LINE"
           else
             READLINE_POINT=0x7fffffff
           fi
        }
        bind -x '"\C-r": __fzf_history__'
        gl() {
          local cmd files
          files=$(sed -nE 's/.* -- (.*)/\1/p' <<< "$*")
          cmd="echo {} |grep -Eo '[a-f0-9]+' |head -1 |xargs -I% git show --color=always % -- $files | cat"
          eval "${pkgs.git-foresta}/bin/git-foresta --topo-order --all" |
            fzf \
            --tiebreak=index --ansi --reverse \
            --bind=ctrl-s:toggle-sort \
            --bind=enter:execute:"$cmd | LESS='-R' less" \
            --bind=ctrl-y:execute-silent:"echo {} |grep -Eo '[a-f0-9]+' | head -1 | ''${COPY_CMD:-wl-copy -n}"
        }
        gstatus() {
          git -c color.status=always status -su
        }
        git_status="git -c color.status=always status -su"
        git_diff="git diff --color=always -- {-1} | less -R"
        git_diff_cached="git diff --cached $@ --color=always -- {-1} | less -R"
        git_add="xargs git add {-1}"
        git_add_p="xargs git add -p {-1} < /dev/tty"
        git_reset="xargs git reset {-1}"
        git_discard="xargs git checkout {-1}"
        git_commit="git commit -v"
        gs() {
          gstatus |
            fzf --reverse --multi --ansi --tiebreak=index \
              --prompt "::$(git branch --show-current)::" \
              --header "git status:" \
              --bind "enter:execute(if (git diff --quiet); then $git_diff_cached; else $git_diff; fi)" \
              --bind "alt-a:execute-silent($git_add)+reload($git_status)" \
              --bind "alt-p:execute($git_add_p)+reload($git_status)" \
              --bind "alt-r:execute-silent($git_reset)+reload($git_status)" \
              --bind "alt-x:execute-silent($git_discard)+reload($git_status)" \
              --bind "alt-c:execute(git commit -v)+reload($git_status)"
        }
        source ${pkgs.fzf-tab-completion}/fzf-bash-completion.sh
        bind -x '"\t": fzf_bash_completion'
      '';
      shellAliases = {
      };
    };

    git = {
      enable = true;
      user = ''
        name = vasile luta
        email = elsile69@yahoo.com
      '';
      core = ''
        editor = ${pkgs._vim}/bin/vim
        pager = ${pkgs.less}/bin/less -S
      '';
      diff = ''
        tool = vimdiff
      '';
      merge = ''
        tool = vimdiff
        conflictStyle = diff3
      '';
      extraConfig = ''
        [commit]
          template = ~/.git-commit-template
      '';
      alias = ''
        lg = log --oneline --graph --all
      '';
      extraPackages = with pkgs; [
        gitAndTools.tig
      ];
    };

    gnupg.agent = {
      enable = true;
    };
    dconf.enable = true;
  };

  environment.etc."xdg/gtk-3.0/settings.ini" = {
    text = ''
      [Settings]
      gtk-icon-theme-name=Paper
      gtk-theme-name=Nordic-bluish-accent
    '';
    mode = "444";
  };

  environment.variables = {
    VISUAL = "${pkgs._vim}/bin/vim";
    EDITOR = "${pkgs._vim}/bin/vim";
    PAGER = "${pkgs.gitAndTools.diff-so-fancy}/bin/diff-so-fancy | ${pkgs.less}/bin/less --tabs=1,5 -RS";
    BAT_PAGER = "${pkgs.less}/bin/less -irRSx4";
    BAT_THEME = "TwoDark";
    MANPAGER = "${pkgs.bash}/bin/sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    PATH = [ "$HOME/.local/bin" ];
  };

  services = {
    redshift.enable = true;
    syncthing.enable = true;
    syncthing.user = "vasy";
    syncthing.openDefaultPorts = true;
    syncthing.dataDir = "/home/vasy/Sync";
    syncthing.configDir = "/home/vasy/Sync/.config/syncthing";
  };

  nix.package = pkgs.nixFlakes;

  nix.extraOptions = ''
    experimental-features = nix-command flakes ca-references recursive-nix progress-bar
  '';
}
