# copied from oh-my-zsh (and cleaned)
alias gc='git commit -v'
alias gcn='git commit -v --no-verify'
alias gcl='git clone --recursive'
alias gco='git checkout'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gpoat='git push origin --all && git push origin --tags'
alias gsb='git status -sb'
alias gsps='git show --pretty=short --show-signature'
alias gst='git status'
alias glstats='git shortlog --summary --numbered --email --all --no-merges' # https://stackoverflow.com/a/9839491/4204843

# my new
alias gitdel='git log --diff-filter=D --summary'

gupd() { 
    git add -v . &&
    git commit -v -m '_' &&
    git push -v origin HEAD 
}
