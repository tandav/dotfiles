alias ls='exa --long --header --group-directories-first'
alias l='exa --long --header --group-directories-first --all'
alias s=subl
alias o=open
alias p=python
alias sz='source ~/.bashrc'
alias req='touch requirements.txt'
alias grep='grep --color=auto'
alias tc='clear; tmux clear-history; clear'
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"


path() { echo $PATH | tr : "\n"; }

function pc() {
    #~/Downloads/pycharm-2022.1.3/bin/pycharm.sh "$1" > /dev/null 2>&1 &
    # charm $1 > /dev/null 2>&1 &
    open -a PyCharm $1
    # open -a "PyCharm CE" $1
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
rgc() { rg --hidden --glob '!.git' .         | fzf; }
rgf() { rg --hidden --glob '!.git' . --files | fzf; }
rgext() { rg --hidden --glob "*.$1" . | fzf; } # search inside jupyter notebooks
ff() { find . -iname "**$1**"; } # ff means find filename

recent() { /bin/ls -hAlt . | head -20; }

killport() { kill -9 $(lsof -ti :$1); }


rt() {
    pic=$HOME/Desktop/$RANDOM.png
    cp $dot/README.png $pic
    open $pic
}


jh() {
    # open -a $dot/OpenJupyter.app . 
    # p $dot/jupyter_opener.py $PWD
    # open "http://localhost:8888/notebooks$(echo $PWD | sed "s|$HOME||")" # https://stackoverflow.com/a/23134318/4204843
    open "http://localhost:8888/notebooks${PWD#$HOME}" # https://stackoverflow.com/a/20615306/4204843
}

ytv() { yt-dlp --no-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output "$HOME/Desktop/%(title)s.%(ext)s" $1; }
yta() { yt-dlp --no-playlist -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "$HOME/Desktop/%(title)s.%(ext)s" $1; }
vid_and_audio() { ffmpeg -i $1 -i $2 -c:v copy -map 0:v:0 -map 1:a:0 -shortest ~/Desktop/out.mp4; }

sshc() { $EDITOR ~/.ssh/config; }
myip() { 
    echo -n "LAN: "
    ifconfig en0 | grep -w inet | cut -d ' ' -f 2
    echo -n "WAN: "
    curl checkip.amazonaws.com # ifconfig.me
}

# ===================== python =======================

# KERNELS_DIR=~/.local/share/jupyter/kernels # linux
KERNELS_DIR=~/Library/Jupyter/kernels # macos

mkkernel() {
    if [ -n "$1" ]; then
        KERNEL_NAME=$1
    elif [ -z "$VIRTUAL_ENV" ]; then
        echo "Pass either kernel name as argument or activate virtualenv"
        return 1
    else [ -z "$1" ]
        KERNEL_NAME="$(basename $VIRTUAL_ENV)"
        echo "No kernel name provided, using name from virtualenv $KERNEL_NAME"
    fi
    pip install ipykernel
    python -m ipykernel install --user --name=$KERNEL_NAME
}

lskernel() { 
    find $KERNELS_DIR -type d -mindepth 1 -maxdepth 1
}

rmkernel() {
    if [ -z "$1" ]; then
        echo "pass kernel name as argument"
        return 1
    fi
    rm -rf "$KERNELS_DIR/$1"
}

jtrust() {
    if [ -z "$1" ]; then
        echo "pass root folder to trust"
        return 1
    fi
    find $1 -name ".ipynb_checkpoints" -prune -o -name "*.ipynb" -exec jupyter trust "{}" +
}


pipd() {
    pip install -e .[dev]
}
