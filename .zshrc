# zmodload zsh/zprof # run zprof to see what slows down zsh startup
# export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.

# export EDITOR="subl -nw"
#export EDITOR="subl"
#export EDITOR='vim'
export EDITOR='nvim'
export BROWSER='Chromium' # Brave Browser, Google Chrome. If change, change also in $pj/n_tabs/com.tandav.n_tabs.plist


export PATH=/usr/local/opt/python@3.10/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export DOTFILES_DIR=~/GoogleDrive/projects/dotfiles
export PATH=$DOTFILES_DIR/bin:$PATH
export PATH="/usr/local/sbin:$PATH" # brew recommendation
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PYTHONPATH=$DOTFILES_DIR/bin:$PYTHONPATH

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=
source "$DOTFILES_DIR/git_aliases.sh"
source "$DOTFILES_DIR/aliases.sh"

export PYTHONPATH=$pj/pipe21:$PYTHONPATH

# -----------------------------------------------------------------------------------------------

# export PROMPT="${ret_status} %m %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)"
# export PS1='%(?.%F{green}.%F{green})%n@%m:%~ $ %f'

NEWLINE=$'\n'
# PROMPT="%B%F{green}%~%b${NEWLINE}$ %f"
# PROMPT="%B%F{green}%~%b${NEWLINE}ॐ  %f"
PROMPT="%B%F{green}%~%b%f${NEWLINE}"
#local host_name="%{$fg[cyan]%}$"
#local path_string="%{$fg[yellow]%}%~"
#local prompt_string="»"
#PROMPT='${host_name} ${path_string} %{$reset_color%}'
# PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
#RPROMPT='[%F{yellow}%?%f]'


# ----------------------------- History command configuration -----------------------------------

# complex topic, need a lot of googling
HISTFILE=~/.zsh_history
HISTSIZE=999999 # how many save in memory per one bash session
# export HISTFILESIZE=
# HISTFILESIZE=100000 # how many save in HISTFILE
# If HISTFILESIZE is not set, no truncation is performed.
SAVEHIST=999999 # how many load in memory (on each startup?)
# setopt histappend
# HISTFILESIZE=
# HISTSIZE=
HISTTIMEFORMAT="%F %T: "
# FROM: https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/history.zsh
## History command configuration
# setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
# setopt share_history          # share command history data
# -----------------------------------------------------------------------------------------------

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)       # Include hidden files.

# Enable Ctrl-x-e to edit command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
bindkey '^[[Z' reverse-menu-complete # enable shift tab backwards navigation

setopt auto_cd
bindkey '^R' history-incremental-search-backward
bindkey -v # vim key bindings

# -----------------------------------------------------------------------------------------------

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
#         . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
#     else
#         export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# -----------------------------------------------------------------------------------------------







#ulimit -n 4096
#sudo sysctl -w kern.maxfiles=100000
#sudo sysctl -w kern.maxfilesperproc=50000


export PATH="$HOME/.poetry/bin:$PATH"
