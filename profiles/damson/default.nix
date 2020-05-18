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
    matrix-dimension = {
      enable = true;
      config = {
        web = {
          port = 8184;
          adress = "1.0.0.0";
        };
        homeserver = {
          name = "t2bot.io";
        };
        accessToken = "something";
        admins = [
          "@someone:domain.com"
        ];
        widgetBlacklist = [
          "10.0.0.0/8"
          "172.16.0.0/12"
          "192.168.0.0/16"
          "127.0.0.0/8"
        ];
        database = {
          file = "dimension.db";
        };
        botData = "dimension.bot.json";
        goneb = {
          avatars = {
            giphy = "mxc://t2bot.io/c5eaab3ef0133c1a61d3c849026deb27";
            imgur = "mxc://t2bot.io/6749eaf2b302bb2188ae931b2eeb1513";
            github = "mxc://t2bot.io/905b64b3cd8e2347f91a60c5eb0832e1";
            wikipedia = "mxc://t2bot.io/7edfb54e9ad9e13fec0df22636feedf1";
            travisci = "mxc://t2bot.io/7f4703126906fab8bb27df34a17707a8";
            rss = "mxc://t2bot.io/aace4fcbd045f30afc1b4e5f0928f2f3";
            google = "mxc://t2bot.io/636ad10742b66c4729bf89881a505142";
            guggy = "mxc://t2bot.io/e7ef0ed0ba651aaf907655704f9a7526";
            echo = "mxc://t2bot.io/3407ff2db96b4e954fcbf2c6c0415a13";
            circleci = "mxc://t2bot.io/cf7d875845a82a6b21f5f66de78f6bee";
            jira = "mxc://t2bot.io/f4a38ebcc4280ba5b950163ca3e7c329";
          };
        };
        telegram = {
          botToken = "YourTokenHere";
        };
        stickers = {
          enabled = true;
          stickerBot = "@stickers:t2bot.io";
          managerUrl = "https://stickers.t2bot.io";
        };
        dimension = {
          publicUrl = "https://dimension.example.org";
        };
        logging = {
          file = "logs/dimension.log";
          console = true;
          consoleLevel = "info";
          fileLevel = "verbose";
          rotate = {
            size = 52428800;
            count = 5;
          };
        };
      };
    };
  };

  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;

}
