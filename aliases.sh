alias ls='ls -G'
alias l='ls -hAlt'
alias md='mkdir -p'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias s='subl'
alias o='open'
#alias vim='nvim'

# d() {
#     [ -z "$1" ] && cat $DOTFILES_DIR/cd_mapping.csv && return 0
#     [ "$1" = 's' ] && s $DOTFILES_DIR/cd_mapping.csv && return 0
#     cd ~
#     cd "$(grep -w $1 $DOTFILES_DIR/cd_mapping.csv | cut -d ' ' -f 2)"
#     l
#     [ "$2" = 's' ] && s .
#     [ "$2" = 'o' ] && o .
# }

alias crep="grep --color"
export dt=~/Desktop
export dw=~/Downloads
export gd=~/GoogleDrive
export gists=~/GoogleDrive/projects/gists
export doc=~/Documents
export dot=~/GoogleDrive/projects/dotfiles
export cj=~/GoogleDrive/contract-job
export meta=~/GoogleDrive/meta
export ai=~/GoogleDrive/play/ai
export bh=~/GoogleDrive/play/bhairava
export pj=~/GoogleDrive/projects
export kn=~/GoogleDrive/knowledge
export sc=~/GoogleDrive/knowledge/buffer/screens

alias tree='s ~/GoogleDrive/meta/tree.txt'

lf() {
    find $gd -type f | 
    grep -v "^${gd}/files" |
    grep -v .idea |
    grep -v .ipynb_checkpoints |
    grep -v .git |
    grep -v __pycache__ > $gd/files/files.txt
    git -C $gd/files diff --unified=0 --exit-code || 
    git -C $gd/files add files.txt && 
    git -C $gd/files commit -m '-' && 
    git -C $gd/files push && 
    echo 'Done'
}


gitgrep() { git grep $1 $(git rev-list --all) }

recent() { l | head -20 }

alias {p,python}='python3'
alias ip='ipython'
alias pip='python -m pip'

alias p37='/usr/local/opt/python@3.7/bin/python3'
alias p38='/usr/local/opt/python@3.8/bin/python3'
alias p39='/usr/local/opt/python@3.9/bin/python3'

alias sz='source ~/.zshrc'

# export LSCOLORS="Gxfxcxdxbxegedabagacad" # maybe colors are better without that line
# Take advantage of $LS_COLORS for completion as well.

alias sm='python ~/GoogleDrive/entrypoint/projects/gists/send_email.py'

# c means content, f means files
# todo: add fallback: grep -ir 'search query' . , find .
rgc() { rg --hidden --glob '!.git' . | fzf }
rgf() { rg --hidden --glob '!.git' . --files | fzf }



hpf() { rsync -azvhP ~/Documents/spaces/contract-job/ssh-vpn/code.sh 'or1:code.sh' }

uc() { python ~/GoogleDrive/projects/gists/clean_url.py $1 | tee /dev/tty | pbcopy }

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

jn () { cd ~ && p -m jupyter notebook }
# jns() { docker run --rm -p 8888:8888 -v $HOME:/home/jovyan jupyter/pyspark-notebook }
jns() { docker run --rm -p 8888:8888 -v $HOME:/home/jovyan -e GRANT_SUDO=yes --user root jupyter/pyspark-notebook }


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
#alias rc='subl ~/.zshrc'
alias rc='$EDITOR ~/.zshrc'
alias al='$EDITOR $DOTFILES_DIR/aliases.sh'

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
# alias gh='open "https://github.com/tandav?tab=repositories"'
alias gh='chrome --app="https://github.com/tandav?tab=repositories" --kiosk'

alias tmp='$EDITOR /Users/tandav/GoogleDrive/projects/tmp_notes'


tm() {
  ssh $1 -t 'tmux -CC a -t my'
}

alias youtube-dl='p -m youtube_dl'

ytv() {
    youtube-dl --no-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output "$HOME/Desktop/%(title)s.%(ext)s" $1
}

yta() {
    youtube-dl --no-playlist -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "$HOME/Desktop/%(title)s.%(ext)s" $1
}

vid_and_audio() {
    ffmpeg -i $1 -i $2 -c:v copy -map 0:v:0 -map 1:a:0 -shortest ~/Desktop/out.mp4
}   

vid_for_twitter() {
    ffmpeg -i $1 -c:v libx264 -crf 18 -c:a copy ~/Desktop/out.mp4
    # If you get height not divisible by 2 (720x405) then add the crop filter:
    # ffmpeg -i $1 -c:v libx264 -crf 18 -vf crop=iw:ih-1 -c:a copy out.mp4
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
myip() { ifconfig en0 | grep -w inet | cut -d ' ' -f 2 }





