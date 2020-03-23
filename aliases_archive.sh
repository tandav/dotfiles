alias subl='open -a Sublime\ Text'
alias tmp='open http://localhost:8888/notebooks/Documents/tmp.ipynb'
alias net='sudo tshark -i en0 -T fields -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
alias net='sudo tshark -i en0 -T fields -e frame.number -e frame.time -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
alias net='sudo tshark -i en0 -T fields -e frame.number -e ip.src -e dns.qry.name -Y 'dns.flags.response eq 0''
netcracker/oracle
alias sqlcl='/Applications/SQLDeveloper.app/Contents/Resources/sqldeveloper/sqldeveloper/bin/sql'
alias nk_cli='sqlcl system/oracle@localhost:1521:xe'
alias nk='open -a IntelliJ\ IDEA & docker start -a netcracker_db'
alias nks='docker stop netcracker_db'
# ff = find filename
ff() { find . -iname "**$1**" }
airpods() {python ~/Documents/spaces/etc/airpods-reconnect/main.py}
# activate env/ virtualenv
alias ve='source env/bin/activate'
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
alias jna='open https://temp-tandav.notebooks.azure.com/nb//notebooks/temp.ipynb' # azure notebook
alias bp='open ~/Documents/spaces/meta/big-pic/pics'
alias i='open -a IntelliJ\ IDEA'
alias aws='sshfs ubuntu@ec2-18-195-144-88.eu-central-1.compute.amazonaws.com:/home/ubuntu/ /Users/tandav/Documents/hn-best/fuse/ -o reconnect,auto_cache,defer_permissions,noappledouble,Compression=no -ovolname=ubuntu-aws-hn-best'
alias hm='python3 ~/GoogleDrive/Notes/etc/htmlmap.py'
# in order to run bm command (create blank map)
export PATH=${PATH}:~/Documents/html-map
