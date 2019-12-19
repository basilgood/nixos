{ config, pkgs, ... }:

{
  imports = [
    ../fonts
    ../base
    ../base-desktop
    ./scripts
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
      tig
      fzf
      kak
      aspell
      aspellDicts.en
      libnotify
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
      shellAliases = {
        glog = "git log --graph --color=always --format='%C(auto)%h%d %s %C(black)%C(bold)%cr' --all";
      };
    };

    git = {
      enable = true;
      user = ''
        name = vasile luta
        email = elsile69@yahoo.com
      '';
      core = ''
        editor = ${pkgs.neovim_configured}/bin/nvim
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
  };

  environment.variables = {
    VISUAL = "${pkgs.neovim_configured}/bin/nvim";
    EDITOR = "${pkgs.neovim_configured}/bin/nvim";
    PAGER = "${pkgs.gitAndTools.diff-so-fancy}/bin/diff-so-fancy | ${pkgs.less}/bin/less --tabs=1,5 -RS";
    BAT_PAGER = "${pkgs.less}/bin/less -irRSx4";
    BAT_THEME = "TwoDark";
    MANPAGER = "${pkgs.bash}/bin/sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    PATH = [ "~/.local/bin" ];
  };

  services = {
    redshift.enable = true;
    syncthing.enable = true;
    syncthing.openDefaultPorts = true;
  };

  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;

}
