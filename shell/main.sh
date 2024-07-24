#!/bin/bash

alias ls='eza --long --header --group-directories-first'
alias l='eza --long --header --group-directories-first --all'
alias grep='grep --color=auto'
alias s=subl
alias o=open
alias sz='source ~/.bash_profile'
alias tc='clear; tmux clear-history; clear'
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
alias rp='python3 $dot/gists/random_password.py'

path() { echo "$PATH" | tr : "\n"; }

loadenv() { export "$(grep -Ev '^(#|$)' .env | xargs)"; }

function pc() {
    if [ "$OS_NAME" == "Darwin" ]; then
        open -a PyCharm "$1"
        # open -a "PyCharm CE" $1
    elif [ "$OS_NAME" == "Linux" ]; then
        #~/Downloads/pycharm-2022.1.3/bin/pycharm.sh "$1" > /dev/null 2>&1 &
        charm "$1" > /dev/null 2>&1 &
    else
        echo "Unknown operating system."
    fi
}

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
function frg {
    # https://news.ycombinator.com/item?id=38473516
    # frg .
    result=$(rg --ignore-case --color=always --line-number --no-heading "$@" |
        fzf --ansi \
            --color 'hl:-1:underline,hl+:-1:underline:reverse' \
            --delimiter ':' \
            --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
    file=${result%%:*}
    linenumber=$(echo "${result}" | cut -d: -f2)
    if [[ -n $file ]]; then
        $EDITOR +"${linenumber}" "$file"
    fi
}

# shellcheck disable=SC2046
# killport() { kill -9 $(lsof -ti :"$1"); }
killport() { lsof -ti :"$1" | xargs kill -9; }
timestamp() { date +%Y-%m-%d-%H%M%S; }
tp() { date "+%Y-%m-%d %H:%M" | pbcopy; }
rt() {
    pic="$HOME/Desktop/$(date -u +%Y-%m-%d-%H%M%S).png"
    cp "$dot/gists/README.png" "$pic"
    open "$pic"
}

ytv() { "$HOME/.cache/virtualenvs/yt-dlp/bin/yt-dlp" --no-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output "$HOME/Desktop/%(title)s.%(ext)s" "$1"; }
yta() { "$HOME/.cache/virtualenvs/yt-dlp/bin/yt-dlp" --no-playlist -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "$HOME/Desktop/%(title)s.%(ext)s" "$1"; }
vid_and_audio() { ffmpeg -i "$1" -i "$2" -c:v copy -map 0:v:0 -map 1:a:0 -shortest ~/Desktop/out.mp4; }

myip() {
    echo -n "LAN: "
    ifconfig en0 | grep -w inet | cut -d ' ' -f 2
    echo -n "WAN: "
    curl checkip.amazonaws.com # ifconfig.me
}

# ====================== tmux ========================

tm() {
    tmux new-session -d -s main -n jobs -c "$HOME"
    # tmux new-session -d -s main

    if [ "$OS_NAME" == "Darwin" ]; then
        # tmux new-window -d -n jobs -c "$HOME"
        tmux send-keys -t main:jobs "workon jupyter" C-m "jupyter notebook --no-browser" C-m

        # # tmux new-window -d -n notes -c "$HOME/docs/notes"
        # tmux split-window -p 66 -h -c "$HOME/docs/notes"
        # tmux send-keys -t main:jobs "workon notes" C-m "make" C-m

        # # tmux new-window -d -n cron -c "$HOME/docs/dotfiles/gists"
        tmux split-window -p 66 -h -c "$HOME/docs/crontab-python"
        tmux send-keys -t main:jobs "workon cron-python" C-m "python cron.py" C-m
    fi
    tmux attach -t main
}

tk() { tmux kill-server; }

# ===================== python =======================

export PIP_DISABLE_PIP_VERSION_CHECK=1
export PYTHONHISTFILE="$HOME/.cache/.python_history"
export PIP_INDEX_URL=https://pypi.tandav.me/index/

alias req='touch requirements.txt'
alias p=python
alias pip='$HOME/.cache/virtualenvs/uv/bin/uv pip'

mkkernel() {
    if [ -n "$1" ]; then
        KERNEL_NAME=$1
    elif [ -n "$VIRTUAL_ENV" ]; then
        KERNEL_NAME="$(basename "$VIRTUAL_ENV")"
        echo "No kernel name provided, using name from virtualenv ($KERNEL_NAME)"
    else
        echo "Pass either kernel name as argument or activate virtualenv"
        return 1
    fi
    pip install ipykernel
    python -m ipykernel install --user --name="$KERNEL_NAME"
}

lskernel() {
    find "$KERNELS_DIR" -mindepth 1 -maxdepth 1 -type d
}

rmkernel() {
    if [ -z "$1" ]; then
        echo "pass kernel name as argument"
        return 1
    fi
    rm -rf "${KERNELS_DIR:?}/$1"
}

jtrust() {
    if [ -z "$1" ]; then
        echo "pass root folder to trust"
        return 1
    fi
    find "$1" -name ".ipynb_checkpoints" -prune -o -name "*.ipynb" -exec jupyter trust "{}" +
}

pipd() {
    pip install -e .[dev]
}

jh() {
    # open -a $dot/OpenJupyter.app .
    # p $dot/jupyter_opener.py $PWD
    # open "http://localhost:8888/notebooks$(echo $PWD | sed "s|$HOME||")" # https://stackoverflow.com/a/23134318/4204843
    # open "http://localhost:8888/notebooks${PWD#"$HOME"}" # https://stackoverflow.com/a/20615306/4204843
    open "http://localhost:8888/tree${PWD#"$HOME"}" # https://stackoverflow.com/a/20615306/4204843
}
