# zmodload zsh/zprof # run zprof to see what slows down zsh startup
# export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export PATH=${PATH}:/usr/local/miniconda3/bin
# export PATH=${PATH}:/Users/tandav/Documents/spaces/contract-job
# export PATH=${PATH}:/Users/tandav/Documents/spaces/python/my_modules
export PYTHONPATH=~/Documents/spaces/python/my_modules

# Path to your oh-my-zsh installation.
# export ZSH=/Users/tandav/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export DOTFILES_DIR='/Users/tandav/Documents/spaces/dotfiles'


# for pyspark
export PYSPARK_PYTHON='/usr/local/bin/python3'
export PYSPARK_DRIVER_PYTHON='/usr/local/bin/python3'
export JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home' # Java 10 is problematic


export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

GREEN='\033[0;32m'
NO_COLOR='\033[0m'
# echo "${GREEN}"
# echo 'Hello, bro!'
# echo 'ॐ  नमः शिवाय'
# echo 'प्रज्ञानम् ब्रह्म'
# echo 'अहम् ब्रह्म अस्मि'
# echo 'तत् त्वम् असि'
# echo 'अयम् आत्मा ब्रह्म'
# echo 'ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    '
# 108 names
# echo 'शिव महेश्वर शम्भू पिनाकी शशिशेखर वामदेव विरूपाक्ष कपर्दी नीललोहित शंकर शूलपाणी खटवांगीविष्णुवल्लभ शिपिविष्ट अंबिकानाथश्रीकण्ठ भक्तवत्सल भव शर्व त्रिलोकेशशितिकण्ठ शिवाप्रिय उग्र कपाली कामारी सुरसूदन गंगाधर ललाटाक्ष महाकाल कृपानिधि भीम परशुहस्त मृगपाणी जटाधर कैलाशवासी कवची कठोर त्रिपुरांतक वृषांक वृषभारूढ़ भस्मोद्धूलितविग्रह सामप्रिय स्वरमयी त्रयीमूर्ति अनीश्वर सर्वज्ञ परमात्मा सोमसूर्याग्निलोचन हवि यज्ञमय सोम पंचवक्त्र सदाशिव विश्वेश्वरवीरभद्र गणनाथ प्रजापति हिरण्यरेता दुर्धुर्ष गिरीश गिरिश्वर अनघ भुजंगभूषण भर्ग गिरिधन्वा गिरिप्रिय कृत्तिवासा पुराराति भगवान् प्रमथाधिप मृत्युंजय सूक्ष्मतनु जगद्व्यापीजगद्गुरू व्योमकेश महासेनजनक चारुविक्रम रूद्र भूतपति स्थाणु अहिर्बुध्न्य दिगम्बर अष्टमूर्ति अनेकात्मा सात्त्विकशुद्धविग्रह शाश्वत खण्डपरशु अज पाशविमोचन मृड पशुपति देव महादेव अव्यय हरि पूषदन्तभित् अव्यग्र दक्षाध्वरहर हर भगनेत्रभिद् अव्यक्त सहस्राक्ष सहस्रपाद अपवर्गप्रद अनंत तारक परमेश्वर'
# echo 'शिव महेश्वर शम्भू पिनाकी शशिशेखर वामदेव विरूपाक्ष कपर्दी नीललोहित शंकर शूलपाणी खटवांगीविष्णुवल्लभ शिपिविष्ट अंबिकानाथश्रीकण्ठ भक्तवत्सल भव शर्व त्रिलोकेशशितिकण्ठ शिवाप्रिय उग्र कपाली कामारी सुरसूदन गंगाधर ललाटाक्ष महाकाल कृपानिधि भीम परशुहस्त मृगपाणी जटाधर कैलाशवासी कवची कठोर त्रिपुरांतक वृषांक वृषभारूढ़'
# echo 'शिव महेश्वर शम्भू पिनाकी शशिशेखर वामदेव विरूपाक्ष कपर्दी नीललोहित'
# echo 'ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ  '
# echo 'ॐ  नमः शिवाय'
# echo "${NO_COLOR}"

# source ~/powerlevel9k/powerlevel9k.zsh-theme
# source "$DOTFILES_DIR/powerlevel9k-airline-theme.sh"
source "$DOTFILES_DIR/oh-my-zsh-aliases.sh"
source "$DOTFILES_DIR/aliases.sh"

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
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data


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

EDITOR='subl -nw'

setopt auto_cd

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# source /Users/tandav/Library/Preferences/org.dystroy.broot/launcher/bash/br
