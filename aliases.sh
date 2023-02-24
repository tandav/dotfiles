alias ls='exa --long --header --group-directories-first'
alias l='exa --long --header --group-directories-first --all'
alias s=subl
alias o=open
alias p=python
alias sz='source ~/.bashrc'
alias rc="$EDITOR ~/.bashrc"
alias al="$EDITOR $dot/aliases.sh"
alias req='touch requirements.txt'
alias grep='grep --color=auto'
alias va='source .venv/bin/activate'
alias tc='clear; tmux clear-history; clear'
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'


path() { echo $PATH | tr : "\n"; }

function pc() {
    #~/Downloads/pycharm-2022.1.3/bin/pycharm.sh "$1" > /dev/null 2>&1 &
    # charm $1 > /dev/null 2>&1 &
    open -a PyCharm $1
    # open -a "PyCharm CE" $1
}


alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"
gl() { git log --oneline --decorate --color | fzf --ansi --preview 'git show $(echo {} | cut -d" " -f1)'; }

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
gitgrep() { git grep $1 $(git rev-list --all); }
# gitgrep() { git grep $1 $(git rev-list --all) *.py; } # specific extension
jn () { cd ~ && p -m jupyter notebook --ip=*; }
jns() { docker run --rm -p 8888:8888 -v $HOME:/home/jovyan -e GRANT_SUDO=yes --user root jupyter/pyspark-notebook; }
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

# python ============================================

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
    # ls ~/.local/share/jupyter/kernels; 
    # find ~/.local/share/jupyter/kernels -type d
    find ~/Library/Jupyter/kernels -type d
}

pip_add() {
    pip install $1
    pip freeze | grep $1 >> requirements.txt
}

pipd() {
    pip install -e .[dev]
}


jtrust() {
    if [ -z "$1" ]; then
        echo "pass root folder to trust"
        return 1
    fi
    find $1 -name ".ipynb_checkpoints" -prune -o -name "*.ipynb" -exec jupyter trust "{}" +
}



