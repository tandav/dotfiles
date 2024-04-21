#!/bin/bash

# set -euo pipefail

export EDITOR=micro

# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LANGUAGE=

HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
# HISTFILESIZE=10000000
# HISTTIMEFORMAT="%F %T: "
HISTFILE=~/.cache/.bash_history

# append to the history file, don't overwrite it
# shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize
shopt -s direxpand # https://askubuntu.com/a/136633/1594515

export dt=~/Desktop
export dw=~/Downloads
export dot=~/docs/dotfiles
export cj=$~/docs/job
export bh=~/docs/bhairava
export PATH=$dot/bin:$PATH
export KEEPASS_DB=$dot/private/tandav.kdbx
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n$ '

export WORKON_HOME=~/.cache/virtualenvs

# =====================================================================================

OS_NAME=$(uname -s)
export OS_NAME

if [ "$OS_NAME" == "Darwin" ]; then
    export SHELL=/usr/local/bin/bash
    source "$dot/shell/macos.sh"
elif [ "$OS_NAME" == "Linux" ]; then
    export SHELL=/usr/bin/bash
    source "$dot/shell/linux.sh"
else
    echo "Unknown operating system."
fi

if [ "$HOSTNAME" == "u60" ]; then
    source "$dot/shell/nvidia.sh"
    export s1=/media/tandav/sg8tb1
    export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'
fi

# =====================================================================================

# export PATH=/usr/bin:$PATH
# export PATH=$HOME/.poetry/bin:$PATH
# alias poetry="~/.local/bin/poetry"
# alias poetry="~/Library/Application\ Support/pypoetry/venv/bin/poetry"
# curl -sSL https://install.python-poetry.org | python3.10 - --version 1.1.15
export PATH=$HOME/.local/bin:$PATH

# =====================================================================================

export LESSHISTFILE="$HOME/.cache/.lesshst"

# =====================================================================================

source "$dot/shell/main.sh"
source "$dot/shell/git.sh"
source "$dot/private/private.sh"

# =====================================================================================

export PATH=$HOME/yandex-cloud/bin:$PATH

# The next line updates PATH for Yandex Cloud CLI.
# if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
# if [ -f "$HOME/yandex-cloud/completion.bash.inc" ]; then source "$HOME/yandex-cloud/completion.bash.inc"; fi

# =====================================================================================

# kubectl
alias k='kubectl'
# source <(kubectl completion bash)
# complete -o default -F __start_kubectl k

# =====================================================================================

source ~/.local/completions/task.bash
