{ pkgs, ... }:

with pkgs;

{
  programs = {
    bash = {
      interactiveShellInit = ''
        FZF_DEFAULT_COMMAND='${fd}/bin/fd --type f --hidden --follow --exclude ".git"'
        FZF_DEFAULT_OPTS="--height 30% \
        --reverse \
        --border \
        --color=dark,pointer:232,hl:208,hl+:208,prompt:10,spinner:10,info:10"
        if [[ :$SHELLOPTS: =~ :(vi|emacs): ]];
        then
          . ${fzf}/share/fzf/completion.bash
          . ${fzf}/share/fzf/key-bindings.bash
          . ${git}/share/git/contrib/completion/git-completion.bash
        fi
        # notes taking
        nt() {
          pushd > /dev/null ~/.notes
          previous_file="$1"
          file_to_edit=`select_file $previous_file`
          if [ -n "$file_to_edit" ] ; then
            "$EDITOR" "$file_to_edit"
            notes "$file_to_edit"
          fi
          popd > /dev/null
        }
        select_file() {
          given_file="$1"
          ${fzf}/bin/fzf \
          --preview="${bat}/bin/bat --color=always {}" \
          --preview-window=right:70%:wrap --query="$given_file"
        }
        # tl - list sessions or create new tmux session
        tl() {
          [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
          if [ $1 ]; then
            tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
          fi
          session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0 --reverse --height 30%) &&  tmux $change -t "$session" || echo "No sessions found."
        }
        # bash history
        __fzf_history__() {
        local output
        output=$(
          builtin history -n
          builtin fc -lnr -2147483648 |
            last_hist=$(HISTTIMEFORMAT=''' builtin history 1) perl -n -l0 -e 'BEGIN { getc; $/ = "\n\t"; $HISTCMD = $ENV{last_hist} + 1 } s/^[ *]//; print $HISTCMD - $. . "\t$_" if !$seen{$_}++' |
            FZF_DEFAULT_OPTS="--height ''${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m --read0" $(__fzfcmd) --query "$READLINE_LINE"
        ) || return
        READLINE_LINE=''${output#*$'\t'}
        if [ -z "$READLINE_POINT" ]; then
          echo "$READLINE_LINE"
        else
          READLINE_POINT=0x7fffffff
        fi
        }
        # git completion
        is_in_git_repo() {
          ${git}/bin/git rev-parse HEAD >/dev/null 2>&1
        }
        gh() {
          is_in_git_repo || return
          local item
          __git_log |
            ${fzf}/bin/fzf --height '50%' "$@" --border --ansi --no-sort --reverse --multi |
            --bind "ctrl-s:toggle-sort" \
            --bind "ctrl-j:preview-down,ctrl-k:preview-up" \
            grep -o "[a-f0-9]\{7,\}" |
            head -n1 |
            while read item; do echo -n "''${(q)item} "; done
        }
        fzf-down() {
          ${fzf}/bin/fzf --height 90% "$@" --reverse
        }
        gf() {
          is_in_git_repo || return
          git -c color.status=always status --short |
          fzf-down -m --ansi --nth 2..,.. \
          --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
          cut -c4- | sed 's/.* -> //'
        }
        gb() {
          is_in_git_repo || return
          git branch -a --color=always | grep -v '/HEAD\s' | sort |
          fzf-down --ansi --multi --tac --preview-window right:70% \
          --preview 'git log --oneline --graph \
          --date=short --color=always \
          --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -200' |
          sed 's/^..//' | cut -d' ' -f1 |
          sed 's#^remotes/##'
        }
        gt() {
          is_in_git_repo || return
          git tag --sort -version:refname |
          fzf-down --multi --preview-window right:70% \
          --preview 'git show --color=always {} | head -200'
        }
        gh() {
          is_in_git_repo || return
          git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" --all |
          fzf-down --ansi --no-sort --reverse --multi \
          --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} |
          xargs git show --color=always | head -200' |
          grep -o "[a-f0-9]\{7,\}"
        }
        gr() {
          is_in_git_repo || return
          git remote -v | awk '{print $1 "\t" $2}' | uniq |
          fzf-down --tac \
            --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
          cut -d$'\t' -f1
        }
        gs() {
          is_in_git_repo || return
          git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
          cut -d: -f1
        }
        if [[ $- =~ i ]]; then
          bind '"\er": redraw-current-line'
          bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
          bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
          bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
          bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
          bind '"\C-g\C-r": "$(gr)\e\C-e\er"'
          bind '"\C-g\C-s": "$(gs)\e\C-e\er"'
        fi
      '';
    };
  };
}
