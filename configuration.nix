{ config, lib, pkgs, ... }:
let
  myvim = with pkgs; vim_configurable.override { python = python3; };
in
{
  imports = [
    ./modules
    # ./local.nix
    ./hosts/plumfive
  ];
}
