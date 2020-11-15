{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    editor = "vim";
    extraPackages = [ pkgs.tig ];
    difftool = "vim";
    mergetool = "vim";
  };
}
