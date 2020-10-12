{ config, pkgs, ... }:
{
  programs.bash.interactiveShellInit = ''
    FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude '.git' --exclude 'node_modules'"
    FZF_DEFAULT_OPTS="--height=15 --reverse --no-info --color=16 --cycle"
    FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
    fi
    k() {
      ps -ef | sed 1d | fzf --reverse --height=10 | awk '{print $2}' | xargs kill -''${1:-9}
    }
    # tmux create session
    t() {
      [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
      if [ $1 ]; then
      tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
      fi
      session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null |
      fzf --reverse --height=10 --exit-0) &&
      tmux $change -t "$session" ||
      echo "No sessions found."
    }
    # fasdlike
    f() {
    pushd ./ > /dev/null
    [ "$#" != 0 ] && cd "$@"
    old_folder=$(pwd)
    cur_folder="$old_folder"
    while true; do
      query=$(test "$keep_query" && echo "$query" || echo ''')
      {
        read query
        read key
        read ret
      } <<<$(
        (ls -1Av --group-directories-first --color=always) |
          ${pkgs.fzf}/bin/fzf --ansi --reverse --exit-0 \
            --print-query --query="$query" \
            --header="''${cur_folder/#$HOME/'~'} $query" \
            --expect=left,right \
            --preview-window=hidden \
            --bind '?:toggle-preview' \
            --preview " \
            [[ -d $(echo {}) ]] && ls -A --color {} ||
            ${pkgs.bat}/bin/bat {} --color=always"
      )
      code=$?
      keep_query=
      query=$(test "$query" && echo "$query" || echo "$ret")
      clear
      echo $code $key $ret
      case $code in
        130)
          output="$old_folder"
          break
          ;;
        0 | 1)
          case $key in
            'left')
              cd ..
              cur_folder=$(pwd)
              ;;
            'right')
              [ -d "$ret" ] && cd "$ret" ||
              ([ $(xdg-mime query filetype "$ret" |
              awk '/text|json|javascript|x-yaml/') ] &&
              $EDITOR "$ret" || xdg-open "$ret")
              cur_folder=$(pwd)
              ;;
            'up')
              cd $HOME/Projects
              cur_folder=$(pwd)
              ;;
            *)
              cd "$ret"
              output=$(pwd)
              break
              ;;
          esac
          ;;
        *)
        # output="$old_folder"
        # break
        # ;;
      esac
      done
    }
  '';
}
