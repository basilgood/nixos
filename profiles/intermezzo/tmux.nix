{ config, pkgs, lib, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    extraConfig = ''
      set -g @resurrect-save 'C-s'
      set -g @resurrect-restore 'C-r'
      set -g @resurrect-capture-pane-contents 'on'
      run-shell ${pkgs.tmuxPlugins.resurrect.rtp}
    '';
  };
}
