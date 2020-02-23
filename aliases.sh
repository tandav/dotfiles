# apps & tools
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias s='subl'

alias sz='source ~/.zshrc'

# export LSCOLORS="Gxfxcxdxbxegedabagacad" # maybe colors are better without that line
# Take advantage of $LS_COLORS for completion as well.
alias ls='ls -G'

alias tmp='open http://localhost:8888/notebooks/Documents/tmp.ipynb'
alias rp='python ~/Documents/spaces/dotfiles/random_password.py'
alias sm='python ~/Documents/spaces/etc/send_email.py'
alias gists='cd ~/Documents/spaces/etc/gists; s .'
alias rgc='rg . | fzf'
alias rgf='rg . --files | fzf'
 
hpf() { rsync -azvhP ~/Documents/spaces/contract-job/ssh-vpn/code.sh 'or1:code.sh' }

alias ut='python -c "from time import time; print(int(time() * 1000))"' # unix time

# cd to folder
alias doc='cd ~/Documents/'
alias ds='cd ~/Documents/spaces'
alias dt='cd ~/Desktop'
alias dw='cd ~/Downloads'
# alias u='cd ~/Documents/spaces/steth/ultrasonic-stethoscope'
# alias uv='cd ~/Documents/Ultrasonic-Stethoscope && source .steth/bin/activate'
alias dot='subl ~/Documents/spaces/dotfiles'


alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias pc='open -a PyCharm\ CE'

# alias net='sudo tshark -i en0 -T fields -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
# alias net='sudo tshark -i en0 -T fields -e frame.number -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
# alias net='sudo tshark -i en0 -T fields -e frame.number -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''

alias wttr='curl wttr.in/voronezh'
alias mtop='open /Applications/Utilities/Activity\ Monitor.app'
alias docker_size='du -h /Users/tandav/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2'
alias yts='echo "document.getElementsByTagName(\"video\")[0].playbackRate = 3" | pbcopy'

alias np='echo "import numpy as np\nimport matplotlib.pyplot as plt" | pbcopy'
alias spark='echo "from pyspark.sql import SparkSession\nspark = SparkSession.builder.enableHiveSupport().getOrCreate()" | pbcopy'

# netcracker/oracle
# alias sqlcl='/Applications/SQLDeveloper.app/Contents/Resources/sqldeveloper/sqldeveloper/bin/sql'
# alias nk_cli='sqlcl system/oracle@localhost:1521:xe'
# alias nk='open -a IntelliJ\ IDEA & docker start -a netcracker_db'
# alias nks='docker stop netcracker_db'

# alias backup='rsync --info=all4 --delete -arR --exclude="**node_modules**" --exclude="**lib/python**" --files-from=/Users/tandav/GoogleDrive/Notes/etc/backup-dirs.txt ~ /Volumes/MyPassport/backup --log-file=/Volumes/MyPassport/backup/latest-backup.log'
alias bu='borgmatic --config /Users/tandav/Documents/spaces/dotfiles/borgmatic-config.yaml --verbosity 2'
alias bl='borg list /Volumes/SanDisk64GB/borg-backup-repo'


timestamp() { python -c 'from time import time; print(int(time() * 1000))' }

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



alias o='open'

alias python3='/usr/local/opt/python@3.8/bin/python3'
alias python='python3'
alias p='python3'
alias pip='python -m pip'
alias ip='ipython'



# also s -a or --add: Add folders to the current window
# or s folder1 folder2: open many folders / files in one window
alias rc='subl ~/.zshrc'
alias al='subl ~/Documents/spaces/dotfiles/aliases.sh'

alias d='python3  ~/Documents/spaces/brain-tools/finder-pro/dashboard/dashboard.py'

# activate env/ virtualenv
# alias ve='source env/bin/activate'
# alias sd='source deactivate'

# alias t='cd ~/Desktop && touch'
rt() {
    if [ -z "$1" ]; then
        pic="$(openssl rand -hex 4).png"
    else
        pic=$1.png
    fi
    # echo $pic
    cd ~/Desktop
    cp "${DOTFILES_DIR}/README.png" $pic
    open $pic
}

alias rand_music='python /Users/tandav/Documents/spaces/etc/gists/random_music_track.py'

# alias jn='jupyter notebook'
# alias jl='jupyter lab'
# alias jnc='open https://colab.research.google.com/notebook#fileId=1tMXb4IXryuenlUvIBkRgZlSQmrlp5mUr&scrollTo=gXzvGiMJD4rQ' # temp colab notebook 
# alias jna='open https://temp-tandav.notebooks.azure.com/nb//notebooks/temp.ipynb' # azure notebook
alias bp='open ~/Documents/spaces/meta/big-pic/pics'
alias ms='cd ~/Documents/spaces/millionaire/spring'
alias mr='cd ~/Documents/spaces/millionaire/millionaire-react'
alias i='open -a IntelliJ\ IDEA'
# alias aws='sshfs ubuntu@ec2-18-195-144-88.eu-central-1.compute.amazonaws.com:/home/ubuntu/ /Users/tandav/Documents/hn-best/fuse/ -o reconnect,auto_cache,defer_permissions,noappledouble,Compression=no -ovolname=ubuntu-aws-hn-best'
# alias hm='python3 ~/GoogleDrive/Notes/etc/htmlmap.py'
# in order to run bm command (create blank map)
# export PATH=${PATH}:~/Documents/html-map

# websites
alias wm='open https://www.youtube.com/playlist\?list\=PL4qBE1-4ZNC0Wam6r8MaZoUfZ8ektEVYe'
alias dnb="open 'https://www.youtube.com/watch?v=OiuKZAkYqyE&index=4&list=PL4qBE1-4ZNC25bKGMcMICdIf9C2KqEcNv'"
alias gist='open https://gist.github.com/tandav'
alias wf='open https://workflowy.com'
alias yt='open https://www.youtube.com'
alias tj='python ~/Documents/spaces/etc/tj-vc-lite/tj.py'
alias vc='python ~/Documents/spaces/etc/tj-vc-lite/vc.py'
alias gh='open "https://github.com/tandav?tab=repositories"'

# alias music='open https://github.com/tandav/life/tree/master/music'
alias gmail='open https://mail.google.com'
# alias h='open -a Safari file:///Users/tandav/Documents/meta/map/shortcuts.svg'
alias h='open -a Safari http://localhost:4000/space/root'

tm() {
  ssh $1 -t 'tmux -CC a -t my'
}

yta() {
    youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 $1
}

vid_and_audio() {
    ffmpeg -i $1 -i $2 -c:v copy -map 0:v:0 -map 1:a:0 -shortest out.mp4
}

airpods() {python ~/Documents/spaces/etc/airpods-reconnect/main.py}

gupd() {
  git add .
  git commit -m '_'
  git push
}

hg() { history -99999 | grep $1 }

# duck duck go search
ddg() { open "https://duckduckgo.com/?q=$1" }

# ff = find filename
# ff() { find . -iname "**$1**" }

sshc() { s ~/.ssh/config }

alias code='/Volumes/SanDisk64GB/apps/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'

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
alias myip="ifconfig getifaddr en0"
