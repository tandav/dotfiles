export dt=~/Desktop
export dw=~/Downloads
export gd=~/GoogleDrive
export pj=$gd/projects
export kn=$gd/knowledge
export gists=$pj/gists
export dot=$pj/dotfiles
export cj=$gd/contract-job
export meta=$kn/_meta
export ai=$kn/math/ai
export bh=$pj/bhairava
export sc=$kn/_etc/screens

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
# ff() { find . -iname "**$1**" } # ff means find filename
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
