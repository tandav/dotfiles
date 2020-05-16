alias ls='ls -G'
alias l='ls -hAlt'
alias md='mkdir -p'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias s='subl'
alias o='open'


# d() {
#     [ -z "$1" ] && cat $DOTFILES_DIR/cd_mapping.csv && return 0
#     [ "$1" = 's' ] && s $DOTFILES_DIR/cd_mapping.csv && return 0
#     cd ~
#     cd "$(grep -w $1 $DOTFILES_DIR/cd_mapping.csv | cut -d ' ' -f 2)"
#     l
#     [ "$2" = 's' ] && s .
#     [ "$2" = 'o' ] && o .
# }


export dt=~/Desktop
export dw=~/Downloads
export gd=~/Documents/GoogleDrive
export gists=~/Documents/spaces/etc/gists
export ep=~/Documents/GoogleDrive/entrypoint
export doc=~/Documents
export ds=~/Documents/GoogleDrive/spaces
export dot=~/Documents/GoogleDrive/entrypoint/projects/dotfiles
export cj=~/Documents/GoogleDrive/entrypoint/contract-job
export meta=~/Documents/GoogleDrive/entrypoint/play
export ai=~/Documents/GoogleDrive/entrypoint/play/ai
export pj=~/Documents/GoogleDrive/entrypoint/projects
export kn=~/Documents/GoogleDrive/entrypoint/knowledge



recent() { l | head -10 }

alias {p,python}='python3'
alias ip='ipython'
alias pip='python -m pip'

alias sz='source ~/.zshrc'

# export LSCOLORS="Gxfxcxdxbxegedabagacad" # maybe colors are better without that line
# Take advantage of $LS_COLORS for completion as well.

alias sm='python ~/Documents/GoogleDrive/entrypoint/projects/gists/send_email.py'

# c means content, f means files
# todo: add fallback: grep -ir 'search query' . , find .
alias rgc='rg . | fzf'
alias rgf='rg . --files | fzf'



hpf() { rsync -azvhP ~/Documents/spaces/contract-job/ssh-vpn/code.sh 'or1:code.sh' }

uc() { python ~/Documents/GoogleDrive/entrypoint/projects/gists/clean_url.py $1 | tee /dev/tty | pbcopy }

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias pc='open -a PyCharm\ CE'


alias mtop='open "/System/Applications/Utilities/Activity Monitor.app"'
alias docker_size='du -h /Users/tandav/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2'
alias yts='echo "document.getElementsByTagName(\"video\")[0].playbackRate = 3" | pbcopy'

alias np='echo "import numpy as np\nimport matplotlib.pyplot as plt" | pbcopy'
alias spark='echo "from pyspark.sql import SparkSession\nspark = SparkSession.builder.enableHiveSupport().getOrCreate()" | pbcopy'



# alias backup='rsync --info=all4 --delete -arR --exclude="**node_modules**" --exclude="**lib/python**" --files-from=/Users/tandav/GoogleDrive/Notes/etc/backup-dirs.txt ~ /Volumes/MyPassport/backup --log-file=/Volumes/MyPassport/backup/latest-backup.log'
alias bu='borgmatic --config /Users/tandav/Documents/spaces/dotfiles/borgmatic-config.yaml --verbosity 2'
alias bl='borg list /Volumes/SanDisk64GB/borg-backup-repo'

jn () { cd ~ && jupyter notebook }
jns() { docker run --rm -p 8888:8888 -v $HOME:/home/jovyan jupyter/pyspark-notebook }


lt() {
    cd ~/Documents/spaces/etc/716090045ddf6c076d7591dfe97bde23
    ./update.sh
}

alias ns='osascript ~/Documents/spaces/etc/night_shift/open_night_shift.applescript'

sn() {
    cd ~/Documents/space-notes
    serve -s gui/build -p 4000 & 
    FLASK_APP=server.py flask run --port 5001 &
    jupyter notebook --no-browser --notebook-dir=~ &
    # jupyter lab --no-browser --notebook-dir=~ &
    sleep 2
    open http://localhost:4000/space/root
}




# also s -a or --add: Add folders to the current window
# or s folder1 folder2: open many folders / files in one window
alias rc='subl ~/.zshrc'
alias al='subl $DOTFILES_DIR/aliases.sh'

alias ddd='python3  ~/Documents/spaces/brain-tools/finder-pro/dashboard/dashboard.py'


rt() {
    pic=$HOME/Desktop/$RANDOM.png
    cp $DOTFILES_DIR/README.png $pic
    open $pic
}


jnh() {
    # open -a $DOTFILES_DIR/OpenJupyter.app . 
    p $DOTFILES_DIR/jupyter_opener.py $PWD
}

# websites
alias wm='open https://www.youtube.com/playlist\?list\=PL4qBE1-4ZNC0Wam6r8MaZoUfZ8ektEVYe'
alias dnb="open 'https://www.youtube.com/watch?v=OiuKZAkYqyE&index=4&list=PL4qBE1-4ZNC25bKGMcMICdIf9C2KqEcNv'"
alias gist='open https://gist.github.com/tandav'
alias yt='open https://www.youtube.com'
alias gh='open "https://github.com/tandav?tab=repositories"'

alias tmp='s /Users/tandav/Documents/GoogleDrive/entrypoint/projects/tmp_notes'

tm() {
  ssh $1 -t 'tmux -CC a -t my'
}

ytv() {
    youtube-dl --no-playlist --output "/Users/tandav/Desktop/%(title)s.%(ext)s" $1
}

yta() {
    youtube-dl --no-playlist -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "/Users/tandav/Desktop/%(title)s.%(ext)s" $1
}

vid_and_audio() {
    ffmpeg -i $1 -i $2 -c:v copy -map 0:v:0 -map 1:a:0 -shortest out.mp4
}


gupd() {
  git add .
  git commit -m '_'
  git push
}

# https://stackoverflow.com/questions/26846738/zsh-history-is-too-short
# alias hg='history 1 | grep'
# alias hg='history 1 | fzf'

# duck duck go search
ddg() { open "https://duckduckgo.com/?q=$1" }

sshc() { s ~/.ssh/config }


bs() {
    open https://news.ycombinator.com
    open https://www.youtube.com
    open https://tweetdeck.twitter.com
    open https://www.reddit.com
    open https://vc.ru
    open https://tjournal.ru
    open https://trrrending.today
    open http://http://130.61.63.6:5000/
}

# Show local ip:
myip() { ifconfig en0 | grep inet }

