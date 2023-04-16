#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

HISTCONTROL=ignoredups
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTTIMEFORMAT="%F %T: "
HISTFILE=~/.bash_history
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
shopt -s direxpand # https://askubuntu.com/a/136633/1594515

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm* | rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *) ;;
esac

# =====================================================================================

export PATH=/usr/bin:$PATH
# export DOCKER_HOST=unix:///run/user/1000/docker.sock
# export EDITOR="subl -nw"
#export EDITOR="subl"
# export EDITOR='nvim'
export EDITOR=vim

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=

#'Safari'  Chromium,  Brave Browser, Google Chrome. If change, change also in $pj/n_tabs/com.tandav.n_tabs.plist
# export BROWSER='Google Chrome'
export dt=~/Desktop
export dw=~/Downloads
export gd=~/docs
export dot=$gd/dotfiles
export cj=$gd/job
export bh=$gd/bhairava
export PATH=$dot/bin:$PATH
export KEEPASS_DB=$dot/private/tandav.kdbx

export WORKON_HOME=~/.cache/.virtualenvs

# mkvirtualenv myenv --python /usr/local/opt/python@3.10/bin/python3.10
# mkvirtualenv libmv-dagops --python python3.11
# mktmpenv --python /usr/local/opt/python@3.10/bin/python3.10

# export PATH=$HOME/.poetry/bin:$PATH
# alias poetry="~/.local/bin/poetry"
# alias poetry="~/Library/Application\ Support/pypoetry/venv/bin/poetry"
export PATH=$HOME/.local/bin:$PATH
# curl -sSL https://install.python-poetry.org | python3.10 - --version 1.1.15

# kubectl
alias k='kubectl'
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
