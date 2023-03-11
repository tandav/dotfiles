#!/bin/bash

alias subl='open -a Sublime\ Text'
alias tmp='open http://localhost:8888/notebooks/Documents/tmp.ipynb'
alias net='sudo tshark -i en0 -T fields -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
alias net='sudo tshark -i en0 -T fields -e frame.number -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
alias net='sudo tshark -i en0 -T fields -e frame.number -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
alias sqlcl='/Applications/SQLDeveloper.app/Contents/Resources/sqldeveloper/sqldeveloper/bin/sql'
alias nk_cli='sqlcl system/oracle@localhost:1521:xe'
alias nk='open -a IntelliJ\ IDEA & docker start -a netcracker_db'
airpods() { python ~/Documents/spaces/etc/airpods-reconnect/main.py; }
alias va='source .venv/bin/activate'
alias sd='source deactivate'
alias t='cd ~/Desktop && touch'
alias wf='open https://workflowy.com'
alias tj='python ~/Documents/spaces/etc/tj-vc-lite/tj.py'
alias vc='python ~/Documents/spaces/etc/tj-vc-lite/vc.py'
alias music='open https://github.com/tandav/life/tree/master/music'
alias gmail='open https://mail.google.com'
alias h='open -a Safari file:///Users/tandav/Documents/meta/map/shortcuts.svg'
alias h='open -a Safari http://localhost:4000/space/root'
alias jn='jupyter notebook'
alias jl='jupyter lab'
alias jnc='open https://colab.research.google.com/notebook#fileId=1tMXb4IXryuenlUvIBkRgZlSQmrlp5mUr&scrollTo=gXzvGiMJD4rQ' # temp colab notebook
alias jna='open https://temp-tandav.notebooks.azure.com/nb//notebooks/temp.ipynb'                                          # azure notebook
alias bp='open ~/Documents/spaces/meta/big-pic/pics'
alias i='open -a IntelliJ\ IDEA'
alias aws='sshfs ubuntu@ec2-18-195-144-88.eu-central-1.compute.amazonaws.com:/home/ubuntu/ /Users/tandav/Documents/hn-best/fuse/ -o reconnect,auto_cache,defer_permissions,noappledouble,Compression=no -ovolname=ubuntu-aws-hn-best'
alias hm='python3 ~/GoogleDrive/Notes/etc/htmlmap.py'
alias tmp='$EDITOR $pj/tmp_notes/tmp.md'
alias spark='echo "from pyspark.sql import SparkSession\nspark = SparkSession.builder.getOrCreate()" | pbcopy'
alias sm='python $gists/send_email.py'
# alias ls='ls -G'
# alias l='ls -hAlt'
# alias ip=ipython
# alias pip='python -m pip'
# alias {p,python}=python3.10
# alias sz='source ~/.zshrc'
# alias rc="$EDITOR ~/.zshrc"
# alias vim='nvim'
# alias rm='rm -i'
# alias md='mkdir -p'
# in order to run bm command (create blank map)
export PATH=${PATH}:~/Documents/html-map

# ================================ ARCHIVE ================================

# search notes:
# rg --glob '*.md' search_query .
# grep -ir --include="*.md" search_query .

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
# ytv() { youtube-dl --no-playlist -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' --output "$HOME/Desktop/%(title)s.%(ext)s" $1 }
# yta() { youtube-dl --no-playlist -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output "$HOME/Desktop/%(title)s.%(ext)s" $1 }
# tm() { ssh -vvv $1 -t 'tmux -CC a -t my' }

vid_for_twitter() {
    ffmpeg -i "$1" -c:v libx264 -crf 18 -c:a copy ~/Desktop/out.mp4
    # If you get height not divisible by 2 (720x405) then add the crop filter:
    # ffmpeg -i $1 -c:v libx264 -crf 18 -vf crop=iw:ih-1 -c:a copy out.mp4
}

pserver() {
    link="http://$(myip):8000"
    echo "$link"
    python "$gists/send_email.py" "$link" # send link to my gmail
    python -m http.server
}

pipup() {
    # -n1 flag for xargs that prevents stopping everything, if updating one package fails.
    python -m pip list --outdated --format=freeze | cut -d = -f 1 | xargs -n1 pip3 install -U
}
malware() { launchctl list | grep -v com.apple | sort --key=3; } # thirdparty agents/threads

alias va='. .venv/bin/activate'
function vr() {
    touch requirements.txt
    touch requirements-dev.txt
    rm -rf .venv
    virtualenv .venv
    . .venv/bin/activate
    pip install -r requirements.txt
    pip install -r requirements-dev.txt
}

lf() {
    find "$gd" -type f |
        grep -v "^${pj}/files" |
        grep -v .idea |
        grep -v .ipynb_checkpoints |
        grep -v .git |
        grep -v __pycache__ > "$pj/files/files.txt"
    git -C "$pj/files" diff --unified=0 --exit-code ||
        git -C "$pj/files" add files.txt &&
        git -C "$pj/files" commit -m '-' &&
        git -C "$pj/files" push &&
        echo 'Done'
}

android_sync() { rsync -rauLvhP --delete xi:~/storage/dcim ~/Downloads/android/dcim; }
android_syncw() {
    echo "Android is single source of truth, macOS extra will be deleted"
    rsync -rauLvhP --delete xiw:~/storage/dcim ~/Downloads/android/dcim
    open ~/Downloads/android/dcim
}

dsh() { docker exec -it "$1" /bin/bash; } # jump into container

venvs_upgrade_pip() {
    # 1. list all venv directories in ~/.virtualenvs
    # 2. add suffix /bin/python for each directory
    # 3. run `python -m pip install --upgrade pip` for each python
    find ~/.virtualenvs -type d -mindepth 1 -maxdepth 1 |
        sed 's/$/\/bin\/python/' |
        xargs -I _ bash -c "_ -m pip install --upgrade pip"
}

jn() { cd ~ && p -m jupyter notebook --ip=*; }
jns() { docker run --rm -p 8888:8888 -v "$HOME:/home/jovyan" -e GRANT_SUDO=yes --user root jupyter/pyspark-notebook; }

pip_add() {
    pip install "$1"
    pip freeze | grep "$1" >> requirements.txt
}

change_ttl() {
    sudo sysctl -w net.inet.ip.ttl=65
}
