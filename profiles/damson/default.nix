{ config, pkgs, ... }:
{
  imports = [
    ../fonts
    ../base
    ../base-desktop
  ];

  users.defaultUser = {
    name = "iulian";
    packages = with pkgs; [
      libnotify
      chromium
      firefox
      keepassxc
      kak
      nomachine-client
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
    bash.interactiveShellInit = let hstr = "HSTR_CONFIG=hicolor ${pkgs.hstr}/bin/hstr"; in
      ''
        # hstr
        bind '"\C-r": "\C-a ${hstr} -- \C-j"';
        bind '"\C-xk": "\C-a ${hstr} -k \C-j"'
      '';
    git = rec {
      enable = true;
      editor = "${pkgs.kak}/bin/kak";
      difftool = "vim";
      mergetool = "vim";
    };
    gnupg.agent = {
      enable = true;
    };
  };

  environment.variables = rec {
    VISUAL = "${pkgs.kak}/bin/kak";
    EDITOR = VISUAL;
  };

  services = {
    redshift.enable = true;
    syncthing.enable = true;
    syncthing.openDefaultPorts = true;
  };

  hardware.sane.enable = true;
  hardware.bluetooth.enable = true;

}
