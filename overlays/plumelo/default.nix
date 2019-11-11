self: super:
{
  plumelo = with self; buildEnv {
    name  = "plumelo";
    paths = [
      #general
      ag
      ripgrep
      fd
      p7zip
      unzip
      zip
      ctags
      unrar
      gnumake
      ntfs3g
      usbutils
      killall
      neomutt
      lf
      bat
      bash_5

      # monitoring
      htop
      lazygit

      # browsers
      firefox
      chromium

      # communication
      libnotify
      (weechat.override {configure = {availablePlugins, ...}: {
        plugins = with availablePlugins; [
          (python.withPackages (ps: with ps; [
            websocket_client
          ]))
        ];};
      })

      # accounting
      ledger

      # editors
      vimHugeX
      neovim

      # misc
      keepassxc

      # sway
      pavucontrol
      imv
      mpg123
    ];
  };
}
