{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/base
    ../../profiles/base-desktop
    ../../profiles/fonts
    ../../profiles/intermezzo/users.nix
    ../../profiles/intermezzo/sway.nix
    ../../profiles/intermezzo/networking.nix
    ../../profiles/intermezzo/environment.nix
    ../../profiles/intermezzo/bashrc.nix
    ../../profiles/intermezzo/tmux.nix
    ../../profiles/intermezzo/git.nix
    ../../profiles/intermezzo/syncthing.nix
    ../../profiles/intermezzo/virtualisation.nix
    ../../profiles/intermezzo/utils.nix
  ];
  networking.hostName = "hermes";
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/mjlbach/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = pkgs.neovim-nightly;
    configure = {
      customRC = ''
        source ~/.config/nvim/init.vim";
      '';
      # packages.myVimPackage.start = with pkgs.vimPlugins; [
      #   fzf-vim
      #   nvim-lspconfig
      # ];
    };
  };
}
