{ config, options, lib, pkgs, ... }: {
  programs.bash = {
    shellAliases = {
      "~" = "cd ~";
      ".." = "cd ../";
      grep = "grep --color=auto";
    };
    promptInit = ''
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
      DIR=''
      JOBS='✦'
      NIX='❄'
      CONTINUED='↪︎'
      GIT=''
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
          echo "$SPACE"$GREEN$GIT$SPACE$branch$RED$meta$RST
        fi
      }
      function nix_module {
        [ -n "$IN_NIX_SHELL" ] && echo "$SPACE"$CYAN$NIX$RST
      }
      function dir_module {
        echo $BLUE$DIR$SPACE'\w'$RST
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

      eval "$(direnv hook bash)"
    '';
    interactiveShellInit = ''
      shopt -s autocd
      shopt -s cdspell
      shopt -s direxpand
      shopt -s histappend
      set -o notify
      bind 'set completion-ignore-case on'
      bind 'set completion-map-case on'
      bind 'set show-all-if-ambiguous on'
      bind 'set menu-complete-display-prefix on'
      bind 'set mark-symlinked-directories on'
      bind 'set colored-stats on'
      bind 'set visible-stats on'
      bind 'set page-completions off'
      bind 'set skip-completed-text on'
      bind 'set bell-style none'
      bind 'Tab: menu-complete'
      bind '"\e[Z": menu-complete-backward'
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[M": kill-word'
      bind '"\C-h": backward-kill-word'
      HISTSIZE=-1
      HISTFILESIZE=-1
      HISTIGNORE="&:[ ]*:exit:l:ls:ll:bg:fg:history*:clear:kill*:?:??"

      stty -ixon
    '';
  };
}
