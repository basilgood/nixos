{ config, options, lib, pkgs, ... }:
with pkgs.tmuxPlugins;
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    keyMode = "vi";
    extraTmuxConf = ''
      # Automatically set window title
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      set-option -g renumber-windows on

      set-window-option -g xterm-keys on
      set -ga terminal-overrides ",xterm-256color:Tc"

      set -g focus-events on

      setw -g mouse on
      setw -g monitor-activity on

      unbind C-b
      set -g prefix C-Space
      bind C-Space send-prefix

      bind -n M-v split-window -h
      bind -n M-s split-window -v

      bind -n M-j resize-pane -D 5
      bind -n M-k resize-pane -U 5
      bind -n M-h resize-pane -L 5
      bind -n M-l resize-pane -R 5

      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      bind -n M-,  previous-window
      bind -n M-. next-window

      set -g @theme "one"
      set -g @theme-background "dark"

      set -g status-left-length 30
      set -g status-right "#{prefix_highlight} #[fg=colour9]#(cd #{pane_current_path}; git diff --quiet || echo '***')"

      set -g @resurrect-processes '\
        "~nvim->nvim" \
        "~tig->tig" \
      '
      run-shell ${pain-control.rtp}
      run-shell ${sensible.rtp}
      run-shell ${resurrect.rtp}
      run-shell ${tmux-theme.rtp}
      run-shell ${prefix-highlight.rtp}
    '';
  };
}
