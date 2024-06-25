#!/bin/bash

# =====================================================================================

# After each command, append to the history file and reread it
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# =====================================================================================

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi

source "$HOME/.cargo/env"

# python
export KERNELS_DIR=~/.local/share/jupyter/kernels

export WORKON_HOME=~/.cache/virtualenvs
export VIRTUALENVWRAPPER_PYTHON=~/.cache/virtualenvs/virtualenvwrapper/bin/python
export VIRTUALENVWRAPPER_VIRTUALENV=~/.cache/virtualenvs/virtualenvwrapper/bin/virtualenv
source ~/.cache/virtualenvs/virtualenvwrapper/bin/virtualenvwrapper.sh

# virtualenvwrapper
# source ~/.local/bin/virtualenvwrapper.sh
