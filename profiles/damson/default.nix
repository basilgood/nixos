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
      element-desktop
      wget
      archivemount
      unzip
      zip
      unrar
      jq
      htop
      bat
      usbutils
      bashmount
      psmisc
      hicolor_icon_theme
      tig
      fzf
      nix-prefetch-scripts
      aspell
      aspellDicts.en
      mpv-with-scripts
      spotify
      feh
      zathura
      firefox
      chromium
      keepassxc
      libnotify
      _vim
      _nvim
      parsec-client
      direnv
    ];
  };

  networking.networkmanager.enable = true;
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
        if [[ :$SHELLOPTS: =~ :(vi|emacs): ]]; then
          . ${pkgs.fzf}/share/fzf/completion.bash
          . ${pkgs.fzf}/share/fzf/key-bindings.bash
          . ${pkgs.git}/share/git/contrib/completion/git-completion.bash
        fi
        export FZF_DEFAULT_OPTS='--height 40% --layout=reverse'
        bind -x '"\C-r": history -n; __fzf_history__'
        hm() {
          history -n |
          sed 's/[[:space:]]*$//' $HISTFILE | tac | awk '!x[$0]++' | tac | ${pkgs.moreutils}/bin/sponge $HISTFILE |
          history -w
        }
        gl() {
          local cmd files
          files=$(sed -nE 's/.* -- (.*)/\1/p' <<< "$*")
          cmd="echo {} |grep -Eo '[a-f0-9]+' |head -1 |xargs -I% git show --color=always % -- $files | cat"
          eval "${pkgs.git-foresta}/bin/git-foresta --topo-order --all" |
            fzf \
            --tiebreak=index --ansi --reverse --height 100% \
            --bind=ctrl-s:toggle-sort \
            --bind=enter:execute:"$cmd | LESS='-R' less" \
            --bind=ctrl-y:execute-silent:"echo {} |grep -Eo '[a-f0-9]+' | head -1 | ''${COPY_CMD:-wl-copy -n}"
        }
        lfcd () {
          tmp="$(mktemp)"
          lf -last-dir-path="$tmp" "$@"
          if [ -f "$tmp" ]; then
            dir="$(cat "$tmp")"
            rm -f "$tmp"
            if [ -d "$dir" ]; then
              if [ "$dir" != "$(pwd)" ]; then
                pushd $@ > /dev/null "$dir"
              fi
            fi
          fi
        }
      '';
      shellAliases = {
        lf = "lfcd";
      };
    };

    git = {
      enable = true;
      user = ''
        name = vasile luta
        email = elsile69@yahoo.com
      '';
      core = ''
        editor = ${pkgs._nvim}/bin/nvim
        pager = ${pkgs.less}/bin/less -S
      '';
      diff = ''
        tool = vimdiff
      '';
      merge = ''
        tool = vimdiff
        conflictStyle = diff3
      '';
      alias = ''
        lg = log --oneline --graph --all
      '';
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
    VISUAL = "${pkgs._nvim}/bin/nvim";
    EDITOR = "${pkgs._nvim}/bin/nvim";
    PAGER = "${pkgs.gitAndTools.diff-so-fancy}/bin/diff-so-fancy | ${pkgs.less}/bin/less --tabs=1,5 -RS";
    BAT_PAGER = "${pkgs.less}/bin/less -irRSx4";
    BAT_THEME = "TwoDark";
    MANPAGER = "${pkgs.bash}/bin/sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    PATH = [ "$HOME/.local/bin" ];
  };

  services = {
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
