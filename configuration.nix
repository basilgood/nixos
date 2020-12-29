{ pkgs, ... }:
{
  imports = [
    ./modules
    ./local.nix
    ./hosts/hermes
  ];
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
