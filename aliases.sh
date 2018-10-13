alias s='subl'
alias sz='source ~/.zshrc'

# export LSCOLORS="Gxfxcxdxbxegedabagacad" # maybe colors are better without that line
# Take advantage of $LS_COLORS for completion as well.
alias ls='ls -G'




# Contract Job HP Laptop config
hp() {
  if [ -z "$1" ] ; then
    hp_lan_ip='172.16.36.208' 
  # else
   # hp_lan_ip=$1
  fi
  # echo "$hp_lan_ip"
  # ~/Documents/108/spaces/contract-job
  sshfs tandav@$hp_lan_ip:/home/tandav/ ~/Documents/108/spaces/contract-job/hp-laptop-fuse/ -o reconnect,auto_cache,defer_permissions,noappledouble,Compression=no -ovolname=HP-Laptop
  open -R ~/Documents/108/spaces/contract-job/hp-laptop-fuse
}



alias ut='python -c "from time import time; print(int(time() * 1000))"' # unix time

# cd to folder
alias doc='cd ~/Documents/'
alias dt='cd ~/Desktop'
alias dw='cd ~/Downloads'
alias u='cd ~/Documents/Ultrasonic-Stethoscope'
# alias uv='cd ~/Documents/Ultrasonic-Stethoscope && source .steth/bin/activate'

# apps & tools
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'


alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

# alias net='sudo tshark -i en0 -T fields -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
# alias net='sudo tshark -i en0 -T fields -e frame.number -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
# alias net='sudo tshark -i en0 -T fields -e frame.number -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''

alias termdown='termdown -b'
alias weather='finger voronezh@graph.no'
alias wttr='curl wttr.in/voronezh'
alias mtop='open /Applications/Utilities/Activity\ Monitor.app'
alias docker_size='du -h /Users/tandav/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/Docker.qcow2'
alias yts='echo "document.getElementsByTagName(\"video\")[0].playbackRate = 3" | pbcopy'

alias np='echo "import numpy as np\nimport matplotlib.pyplot as plt" | pbcopy'
# netcracker/oracle
# alias sqlcl='/Applications/SQLDeveloper.app/Contents/Resources/sqldeveloper/sqldeveloper/bin/sql'
# alias nk_cli='sqlcl system/oracle@localhost:1521:xe'
# alias nk='open -a IntelliJ\ IDEA & docker start -a netcracker_db'
# alias nks='docker stop netcracker_db'

# alias backup='rsync --info=all4 --delete -arR --exclude="**node_modules**" --exclude="**lib/python**" --files-from=/Users/tandav/GoogleDrive/Notes/etc/backup-dirs.txt ~ /Volumes/MyPassport/backup --log-file=/Volumes/MyPassport/backup/latest-backup.log'
alias backup='python3 ~/GoogleDrive/Notes/etc/backup.py'
alias bu='borgmatic --config /Users/tandav/Documents/108/dotfiles/borgmatic-config.yaml --verbosity 2'
alias bl='borg list /Volumes/SanDisk64GB/borg-backup-repo'
alias dot='subl ~/Documents/108/dotfiles'

# alias n='subl ~/GoogleDrive/Notes'
alias nt='cd ~/GoogleDrive/Notes'

lt() {
  cd ~/Documents/108/spaces/etc/716090045ddf6c076d7591dfe97bde23
  ./update.sh
}

alias ns='bash ~/Documents/108/spaces/brain-tools/brain-tools/finder-pro/dashboard/scripts/night-shift.sh'

sn() {
  cd ~/Documents/space-notes
  serve -s gui/build -p 4000 & 
  FLASK_APP=server.py flask run &
  sleep 2
  open http://localhost:4000/space/root
}

# alias ng='open https://github.com/tandav/Notes'

alias o='open'

alias python='python3'
# alias p3='python3'

alias p='python3'
alias ip='ipython'

# alias ip3='ipython'

alias s='subl' 
# also s -a or --add: Add folders to the current window
# or s folder1 folder2: open many folders / files in one window
alias rc='subl ~/.zshrc'
alias al='subl ~/Documents/108/dotfiles/aliases.sh'

alias d='python3  ~/Documents/108/spaces/brain-tools/brain-tools/finder-pro/dashboard/dashboard.py'

# activate env/ virtualenv
# alias ve='source env/bin/activate'
# alias sd='source deactivate'


alias rt='cd ~/Desktop && cp ~/Documents/108/dotfiles/README.png . && open README.png'
alias qt='cd ~/Desktop && cp ~/Documents/108/dotfiles/temp-request.py . && s temp-request.py'
alias pt='cd ~/Desktop && cp ~/Documents/108/dotfiles/temp.py . && s temp.py:-1'
alias jn='jupyter notebook'
alias jl='jupyter lab'
alias jnt='jupyter notebook ~/Documents/temp.ipynb' # temporary python
alias jnc='open https://colab.research.google.com/notebook#fileId=1tMXb4IXryuenlUvIBkRgZlSQmrlp5mUr&scrollTo=gXzvGiMJD4rQ' # temp colab notebook 
alias jna='open https://temp-tandav.notebooks.azure.com/nb//notebooks/temp.ipynb' # azure notebook
alias bp='open -a Preview ~/GoogleDrive/images/big-pic'
alias ms='cd ~/Documents/millionaire/spring'
alias mr='cd ~/Documents/millionaire/millionaire-react'
alias i='open -a IntelliJ\ IDEA'
# alias aws='sshfs ubuntu@ec2-18-195-144-88.eu-central-1.compute.amazonaws.com:/home/ubuntu/ /Users/tandav/Documents/hn-best/fuse/ -o reconnect,auto_cache,defer_permissions,noappledouble,Compression=no -ovolname=ubuntu-aws-hn-best'
# alias hm='python3 ~/GoogleDrive/Notes/etc/htmlmap.py'
# in order to run bm command (create blank map)
export PATH=${PATH}:~/Documents/html-map

# websites
alias wm='open https://www.youtube.com/playlist\?list\=PL4qBE1-4ZNC0Wam6r8MaZoUfZ8ektEVYe'
alias gist='open https://gist.github.com/tandav'
alias wf='open https://workflowy.com'
alias yt='open https://www.youtube.com'
alias tj='python ~/Documents/tj-vc-lite/tj.py'
alias vc='python ~/Documents/tj-vc-lite/vc.py'

alias gh='open "https://github.com/tandav?tab=repositories"'
alias rutr='open -a TorBrowser https://rutracker.org'

# alias music='open https://github.com/tandav/life/tree/master/music'
# alias gmail='open https://mail.google.com'
# alias h='open -a Safari file:///Users/tandav/Documents/108/meta/map/shortcuts.svg'
alias h='open -a Safari http://localhost:4000/space/root'
# alias t='cd ~/Desktop && touch'

gupd() {
  git add .
  git commit -m 'upd'
  git push
}
