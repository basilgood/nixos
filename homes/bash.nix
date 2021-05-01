{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" ];
    historySize = -1;
    historyFileSize = -1;
    historyIgnore = [ "l" "ls" "ll" "fg" "bg" "exit" "clear" "kill" "history" ];
    shellOptions = [
      "checkwinsize"
      "globstar"
      "nocaseglob"
      "autocd"
      "dirspell"
      "cdspell"
      "histappend"
      "cmdhist"
    ];
    shellAliases = {
      grep = "grep --color=auto";
    };

    initExtra = ''
      set -o notify
      bind "set completion-ignore-case on"
      bind "set completion-map-case on"
      bind "set show-all-if-ambiguous on"
      bind "set menu-complete-display-prefix on"
      bind "set mark-symlinked-directories on"
      bind "set colored-stats on"
      bind "set visible-stats on"
      bind "set page-completions off"
      bind "set skip-completed-text on"
      bind "set bell-style none"

      bind '"\t": menu-complete'
      bind '"\e[Z": menu-complete-backward'
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[M": kill-word'
      bind '"\C-h": backward-kill-word'

      # prompt
      RED="\[\e[0;31m\]"
      DARKGRAY="\[\e[0;90m\]"
      YELLOW="\[\e[0;33m\]"
      BLUE="\[\e[0;34m\]"
      PURPLE="\[\e[0;35m\]"
      GREEN="\[\e[0;32m\]"
      WHITE="\[\e[0;37m\]"
      CYAN="\[\e[0;34m\]"
      RST="\[\e[0m\]"

      SPACE=' '
      PROMPT='✎'
      JOBS='✦'
      NIX='❄'
      CONTINUED='↪︎'
      AHEAD='⇡'
      BEHIND='⇣'
      DIRTY='*'
      STAGED='+'
      UNTRACKED='?'
      STASH='≡'

      function ret_module {
        [ $exitcode != 0 ] && echo $RED
      }
      function jobs_module {
        jobsval=$(jobs -p | wc -l)
        [ $jobsval -ne 0 ] && echo "$SPACE"$YELLOW$JOBS$RST
      }
      function git_module {
        if [[ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
          git update-index --really-refresh -q &>/dev/null
          local meta
          local branch="$(git symbolic-ref --quiet --short HEAD 2> /dev/null ||
            git rev-parse --short HEAD 2> /dev/null || echo '(unknown)')"
          local status=`command git status --porcelain -b 2>/dev/null`
          branch="''${branch##refs/heads/}"
          [ -z "$branch" ] && branch=""
          [[ "$status" =~ ([[:cntrl:]][A-Z][A-Z\ ]\ ) ]] && meta+=$STAGED
          [[ "$status" =~ ([[:cntrl:]][A-Z\ ][A-Z]\ ) ]] && meta+=$DIRTY
          [[ "$status" =~ ([[:cntrl:]]\?\?\ ) ]] && meta+=$UNTRACKED
          [[ -e "$PWD/.git/refs/stash" ]] && meta+=$STASH
          [[ "$status" =~ ahead\ ([0-9]+) ]] && meta+=$AHEAD''${BASH_REMATCH[1]}
          [[ "$status" =~ behind\ ([0-9]+) ]] && meta+=$BEHIND''${BASH_REMATCH[1]}
          echo "$SPACE"$GREEN$branch$RED$meta$RST
        fi
      }
      function nix_module {
        [ -n "$IN_NIX_SHELL" ] && echo "$SPACE"$CYAN$NIX$RST
      }
      function dir_module {
        echo $BLUE'\w'$RST
      }
      function end_module {
        echo $PROMPT$SPACE$RST
      }
      function set_bash_prompt {
        exitcode="$?"
        PS1='\n'$(dir_module)$(git_module)$(jobs_module)$(nix_module)
        PS1+='\n'$(ret_module)$(end_module)
        PS2="$WHITE$CONTINUED  $RST"
      }
      PROMPT_COMMAND='history -a; set_bash_prompt'

      bind -x '"\C-r": history -n; __fzf_history__'
      hm() {
        history -n |
        sed 's/[[:space:]]*$//' $HISTFILE | tac | awk '!x[$0]++' | tac | ${pkgs.moreutils}/bin/sponge $HISTFILE |
        history -w
      }

      stty -ixon
    '';
  };
}
