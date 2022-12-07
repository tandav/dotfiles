# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoredups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTTIMEFORMAT="%F %T: "
HISTFILE=~/.bash_history

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# After each command, append to the history file and reread it
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows
# PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep -E --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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
export PATH=/usr/local/opt/python@3.10/bin:$PATH
export PATH=/usr/bin:$PATH
# export DOCKER_HOST=unix:///run/user/1000/docker.sock
export GITLAB_HOME=/home/tandav/gitlab
# export EDITOR="subl -nw"
#export EDITOR="subl"
# export EDITOR='nvim'
export EDITOR=vim


export JAVA_HOME='/usr/lib/jvm/java-8-openjdk-amd64'


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


source "$dot/git_aliases.sh"
source "$dot/aliases.sh"
source "$dot/private/private.sh"
export PATH=$dot/bin:$PATH

# nvidia toolkit
export PATH=/usr/local/cuda-11.7/bin:$PATH
# export LD_LIBRARY_PATH=/usr/local/cuda-11.7/lib64:$LD_LIBRARY_PATH
# , or, add /usr/local/cuda-11.7/lib64 to /etc/ld.so.conf and run ldconfig as root

export WORKON_HOME=~/.virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.10/bin/python3.10
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.11/bin/python3.11
export VIRTUALENVWRAPPER_PYTHON="/Library/Frameworks/Python.framework/Versions/3.11/bin/python3.11"
# mktmpenv --python /usr/local/opt/python@3.10/bin/python3.10
# mkvirtualenv myenv --python /usr/local/opt/python@3.10/bin/python3.10

# source ~/.local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper.sh
shopt -s direxpand # https://askubuntu.com/a/136633/1594515



source $dot/macos.sh

# export PATH=$HOME/.poetry/bin:$PATH
# alias poetry="~/.local/bin/poetry"
# alias poetry="~/Library/Application\ Support/pypoetry/venv/bin/poetry"
export PATH=$HOME/.local/bin:$PATH
# curl -sSL https://install.python-poetry.org | python3.10 - --version 1.1.15
