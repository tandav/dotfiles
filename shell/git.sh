#!/bin/bash

# copied from oh-my-zsh (and cleaned)
alias gc='git commit -v'
alias gcn='git commit -v --no-verify'

alias glg0='git log --stat'
alias glg1='git log --stat -p'
alias glg2='git log --graph'
alias glg3='git log --graph --decorate --all'
alias glg4='git log --graph --max-count=10'
alias glg5='git log --oneline --decorate'
alias glg6="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glg7="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glg8="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glg9="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glg10='git log --oneline --decorate --graph'
alias glg11='git log --oneline --decorate --graph --all'

alias gpoat='git push origin --all && git push origin --tags'
alias gsps='git show --pretty=short --show-signature'
alias glstats='git shortlog --summary --numbered --email --all --no-merges' # https://stackoverflow.com/a/9839491/4204843

# my new

gupd() {
    git add --verbose . &&
        git commit --verbose --no-verify --message '_' &&
        git push --verbose origin HEAD
}

gupda() {
    git add --verbose . &&
        git commit --verbose --no-verify --amend --no-edit &&
        git push --verbose --force origin HEAD
}

gpp() {
    git push --verbose
    git push --tags
}

gl() { git log --oneline --decorate --color | fzf --ansi --preview "git show $(echo {} | cut -d' ' -f1)"; }
gitgrep() { git grep "$1" "$(git rev-list --all)"; }
# gitgrep() { git grep "$1" "$(git rev-list --all)" *.py; } # specific extension
