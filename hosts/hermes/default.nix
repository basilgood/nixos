{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware.nix
    ../../profiles/base
    ../../profiles/base-desktop
    ../../profiles/fonts
    ../../profiles/intermezzo/users.nix
    ../../profiles/intermezzo/sway.nix
    ../../profiles/intermezzo/networking.nix
    ../../profiles/intermezzo/environment.nix
    ../../profiles/intermezzo/bashrc.nix
    ../../profiles/intermezzo/tmux.nix
    ../../profiles/intermezzo/neovim.nix
    ../../profiles/intermezzo/git.nix
    ../../profiles/intermezzo/syncthing.nix
    ../../profiles/intermezzo/virtualisation.nix
    ../../profiles/intermezzo/utils.nix
  ];
  networking.hostName = "hermes";
}
