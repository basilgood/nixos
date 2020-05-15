{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules
    ./local.nix
    ./hosts/merlin
  ];
}
