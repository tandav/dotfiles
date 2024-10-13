#!/bin/bash

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n$ '

HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
# HISTFILESIZE=10000000
# HISTTIMEFORMAT="%F %T: "
HISTFILE=~/.cache/.bash_history

# append to the history file, don't overwrite it
# shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize
shopt -s direxpand # https://askubuntu.com/a/136633/1594515

# =====================================================================================

eval "$(zoxide init bash)"

# =====================================================================================

. "$dot/shell/python.sh"

# =====================================================================================

alias ls='eza --long --header --group-directories-first'
alias l='eza --long --header --group-directories-first --all'
alias grep='grep --color=auto'
alias s=subl
alias o=open
alias sz='source ~/.profile'
alias tc='clear; tmux clear-history; clear'
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
alias rp='python3 $dot/gists/random_password.py'

path() { echo "$PATH" | tr : "\n"; }
loadenv() { export "$(grep -Ev '^(#|$)' .env | xargs)"; }

# c means content, f means files
# todo: add fallback: grep -ir 'search query' . , find .
# find files which names that contains `abc` (case-insensitive)
# ```shell
# find . -iname '*abc*'
# ```
# use any wildcsards you want
# (`.` is root node, then it searches recursevly)
# TODO: exclude .venv
rgc() { rg --hidden --glob '!.git' . | fzf; }
rgf() { rg --hidden --glob '!.git' . --files | fzf; }
rgext() { rg --hidden --glob "*.$1" . | fzf; } # search inside jupyter notebooks
ff() { find . -iname "**$1**"; }               # ff means find filename

# shellcheck disable=SC2046
# killport() { kill -9 $(lsof -ti :"$1"); }
killport() { lsof -ti :"$1" | xargs kill -9; }
timestamp() { date +%Y-%m-%d-%H%M%S; }
tp() { python -c 'import datetime; print(datetime.datetime.now().replace(microsecond=0).astimezone().isoformat())' | pbcopy; } # timestamp for blog / pelican
rt() {
    pic="$HOME/Desktop/$(date -u +%Y-%m-%d-%H%M%S).png"
    cp "$dot/gists/README.png" "$pic"
    open "$pic"
}

ytv() { "$HOME/.cache/virtualenvs/yt-dlp/bin/yt-dlp" --no-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output "$HOME/Desktop/%(title)s.%(ext)s" "$1"; }
yta() { "$HOME/.cache/virtualenvs/yt-dlp/bin/yt-dlp" --no-playlist -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "$HOME/Desktop/%(title)s.%(ext)s" "$1"; }
vid_and_audio() { ffmpeg -i "$1" -i "$2" -c:v copy -map 0:v:0 -map 1:a:0 -shortest ~/Desktop/out.mp4; }

# ====================== tmux ========================

tm() {
    tmux new-session -d -s main -n jobs -c "$HOME"
    if [ "$OS_NAME" == "Darwin" ]; then
        tmux send-keys -t main:jobs "workon jupyter" C-m "jupyter notebook --no-browser" C-m
        tmux split-window -h -c "$HOME/docs/crontab-python"
        tmux send-keys -t main:jobs "workon cron-python" C-m "python cron.py" C-m
    fi
    tmux attach -t main
}

tk() { tmux kill-server; }

# git ------------------------------------------------------------

gpp() {
    git push --verbose
    git push --tags
}

gitgrep() { git grep "$1" "$(git rev-list --all)"; }
# gitgrep() { git grep "$1" "$(git rev-list --all)" *.py; } # specific extension

# =====================================================================================

# kubectl
alias k='kubectl'
# source <(kubectl completion bash)
# complete -o default -F __start_kubectl k

# =====================================================================================

# The next line updates PATH for Yandex Cloud CLI.
# if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
# if [ -f "$HOME/yandex-cloud/completion.bash.inc" ]; then source "$HOME/yandex-cloud/completion.bash.inc"; fi

# =====================================================================================
