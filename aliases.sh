export dt=~/Desktop
export dw=~/Downloads
export gd=~/GoogleDrive
export gists=~/GoogleDrive/projects/gists
export dot=~/GoogleDrive/projects/dotfiles
export cj=~/GoogleDrive/contract-job
export meta=~/GoogleDrive/knowledge/_meta
export ai=~/GoogleDrive/play/ai
export bh=~/GoogleDrive/projects/bhairava
export pj=~/GoogleDrive/projects
export kn=~/GoogleDrive/knowledge
export sc=~/GoogleDrive/knowledge/_etc/screens

alias ls='ls -G'
alias l='ls -hAlt'
alias md='mkdir -p'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias s=subl
alias o=open
alias {p,python}=python3
alias ip=ipython
alias pip='python -m pip'
alias sz='source ~/.zshrc'
alias sm="python $gists/send_email.py"
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias pc='open -a "PyCharm CE"'
alias mtop='open -a "Activity Monitor.app"'
alias np='echo "import numpy as np\nimport matplotlib.pyplot as plt" | pbcopy'
alias spark='echo "from pyspark.sql import SparkSession\nspark = SparkSession.builder.enableHiveSupport().getOrCreate()" | pbcopy'
alias rc="$EDITOR ~/.zshrc"
alias al="$EDITOR $DOTFILES_DIR/aliases.sh"
alias ddd="p $ai/brain-tools/finder-pro/dashboard/dashboard.py"
# alias wm="open 'https://www.youtube.com/playlist?list=PL4qBE1-4ZNC0Wam6r8MaZoUfZ8ektEVYe'"
alias wm="open 'https://www.youtube.com/playlist?list=UU45Wdr3wPy1qR2WLUCTsFKg'"
alias dnb="open 'https://www.youtube.com/watch?v=OiuKZAkYqyE&index=4&list=PL4qBE1-4ZNC25bKGMcMICdIf9C2KqEcNv'"
alias gh='chrome --app="https://github.com/tandav?tab=repositories"'
alias tmp="$EDITOR $pj/tmp_notes/tmp.md"
alias youtube-dl='p -m youtube_dl'
alias tree="$EDITOR $meta/tree.txt"
alias mt="open $meta/meta.key"


# c means content, f means files
# todo: add fallback: grep -ir 'search query' . , find .
# find files which names that contains `abc` (case-insensitive) 
# ```shell
# find . -iname '*abc*'
# ```

# use any wildcsards you want
# (`.` is root node, then it searches recursevly)
rgc() { rg --hidden --glob '!.git' .         | fzf }
rgf() { rg --hidden --glob '!.git' . --files | fzf }

# search notes:
# rg --glob '*.md' search_query . 
# grep -ir --include="*.md" search_query .


recent() { l | head -20 }
malware() {launchctl list | grep -v com.apple | sort --key=3 } # thirdparty agents/threads
gitgrep() { git grep $1 $(git rev-list --all) }
jn () { cd ~ && p -m jupyter notebook --ip='*' }
jns() { docker run --rm -p 8888:8888 -v $HOME:/home/jovyan -e GRANT_SUDO=yes --user root jupyter/pyspark-notebook }
killport() { kill $(lsof -ti:$1) }


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
# alias gh='open "https://github.com/tandav?tab=repositories"'
tm() { ssh -vvv $1 -t 'tmux -CC a -t my' }
ytv() { youtube-dl --no-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output "$HOME/Desktop/%(title)s.%(ext)s" $1 }
yta() { youtube-dl --no-playlist -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "$HOME/Desktop/%(title)s.%(ext)s" $1 }
vid_and_audio() { ffmpeg -i $1 -i $2 -c:v copy -map 0:v:0 -map 1:a:0 -shortest ~/Desktop/out.mp4 }   
vid_for_twitter() {
    ffmpeg -i $1 -c:v libx264 -crf 18 -c:a copy ~/Desktop/out.mp4
    # If you get height not divisible by 2 (720x405) then add the crop filter:
    # ffmpeg -i $1 -c:v libx264 -crf 18 -vf crop=iw:ih-1 -c:a copy out.mp4
}

gupd() { git add . && git commit -m '_' && git push }
ddg() { open "https://duckduckgo.com/?q=$1" } # duck duck go search
sshc() { $EDITOR ~/.ssh/config }
myip() { ifconfig en0 | grep -w inet | cut -d ' ' -f 2 } # Show local ip:
dsh() { docker exec -it $1 /bin/bash } # jump into container


# change directory (in terminal) to the current Finder directory
function cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

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

pserver() {
    link="http://$(myip):8000"
    echo "$link"
    python $gists/send_email.py "$link" # send link to my gmail
    python -m http.server
}

# adb connect 192.168.1.179

# ================================ ARCHIVE ================================
# alias ping='ping -c 5'
# hpf() { rsync -azvhP ~/GoogleDrive/contract-job/ssh-vpn/code.sh 'or1:code.sh' }

# https://stackoverflow.com/questions/26846738/zsh-history-is-too-short
# alias hg='history 1 | grep'
# alias hg='history 1 | fzf'

# alias backup='rsync --info=all4 --delete -arR --exclude="**node_modules**" --exclude="**lib/python**" --files-from=/Users/tandav/GoogleDrive/Notes/etc/backup-dirs.txt ~ /Volumes/MyPassport/backup --log-file=/Volumes/MyPassport/backup/latest-backup.log'
# alias bu='borgmatic --config /Users/tandav/Documents/spaces/dotfiles/borgmatic-config.yaml --verbosity 2'
# alias bl='borg list /Volumes/SanDisk64GB/borg-backup-repo'
# alias ns='osascript ~/Documents/spaces/etc/night_shift/open_night_shift.applescript'
# d() {
#     [ -z "$1" ] && cat $DOTFILES_DIR/cd_mapping.csv && return 0
#     [ "$1" = 's' ] && s $DOTFILES_DIR/cd_mapping.csv && return 0
#     cd ~
#     cd "$(grep -w $1 $DOTFILES_DIR/cd_mapping.csv | cut -d ' ' -f 2)"
#     l
#     [ "$2" = 's' ] && s .
#     [ "$2" = 'o' ] && o .
# }

# sn() {
#     cd ~/Documents/space-notes
#     serve -s gui/build -p 4000 & 
#     FLASK_APP=server.py flask run --port 5001 &
#     jupyter notebook --no-browser --notebook-dir=~ &
#     # jupyter lab --no-browser --notebook-dir=~ &
#     sleep 2
#     open http://localhost:4000/space/root
# }

# alias yts='echo "document.getElementsByTagName(\"video\")[0].playbackRate = 3" | pbcopy'

