{ config, pkgs, ... }:
{
  users.defaultUser = {
    name = "vasy";
    packages = with pkgs; [
      imv
      mako
      libnotify
      chromium
      firefox
      ((vim_configurable.overrideAttrs (oldAttrs: rec {
        version = "8.2.1981";
        src = fetchFromGitHub {
          owner = "vim";
          repo = "vim";
          rev = "v${version}";
          hash = "sha256:0z49xjajsj3r6lah9li718ivkasdq8r4c0nxnm0jwwpsrxmmls7k";
        };
      })).override {
        python = python3;
        ftNixSupport = false;
      })
      ((emacsPackagesNgGen emacs).emacsWithPackages (epkgs: [
        epkgs.vterm
      ]))
      wget
      unzip
      usbutils
      mpv-with-scripts
      htop
      ripgrep
      fd
      tree
      bat
      keepassxc
      parsec-client
      spotify
    ];
  };
}
