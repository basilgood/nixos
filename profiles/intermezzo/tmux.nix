{ config, pkgs, lib, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
  };
}
