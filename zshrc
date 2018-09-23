# zmodload zsh/zprof # run zprof to see what slows down zsh startup
export TERM="xterm-256color"
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=${PATH}:/usr/local/mysql/bin
export PATH=${PATH}:/usr/local/miniconda3/bin

# Path to your oh-my-zsh installation.
export ZSH=/Users/tandav/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export DOTFILES_DIR='/Users/tandav/Documents/108/dotfiles'


# export PYTHONSTARTUP=~/Documents/108/dotfiles/python-startup.py


GREEN='\033[0;32m'
# No Color
NC='\033[0m'
echo "${GREEN}"
# echo 'Hello, bro!'
# echo 'प्रज्ञानम् ब्रह्म'
# echo 'अहम् ब्रह्म अस्मि'
# echo 'तत् त्वम् असि'
# echo 'अयम् आत्मा ब्रह्म'
# echo 'ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    ॐ    '
# 108 names
# echo 'शिव महेश्वर शम्भू पिनाकी शशिशेखर वामदेव विरूपाक्ष कपर्दी नीललोहित शंकर शूलपाणी खटवांगीविष्णुवल्लभ शिपिविष्ट अंबिकानाथश्रीकण्ठ भक्तवत्सल भव शर्व त्रिलोकेशशितिकण्ठ शिवाप्रिय उग्र कपाली कामारी सुरसूदन गंगाधर ललाटाक्ष महाकाल कृपानिधि भीम परशुहस्त मृगपाणी जटाधर कैलाशवासी कवची कठोर त्रिपुरांतक वृषांक वृषभारूढ़ भस्मोद्धूलितविग्रह सामप्रिय स्वरमयी त्रयीमूर्ति अनीश्वर सर्वज्ञ परमात्मा सोमसूर्याग्निलोचन हवि यज्ञमय सोम पंचवक्त्र सदाशिव विश्वेश्वरवीरभद्र गणनाथ प्रजापति हिरण्यरेता दुर्धुर्ष गिरीश गिरिश्वर अनघ भुजंगभूषण भर्ग गिरिधन्वा गिरिप्रिय कृत्तिवासा पुराराति भगवान् प्रमथाधिप मृत्युंजय सूक्ष्मतनु जगद्व्यापीजगद्गुरू व्योमकेश महासेनजनक चारुविक्रम रूद्र भूतपति स्थाणु अहिर्बुध्न्य दिगम्बर अष्टमूर्ति अनेकात्मा सात्त्विकशुद्धविग्रह शाश्वत खण्डपरशु अज पाशविमोचन मृड पशुपति देव महादेव अव्यय हरि पूषदन्तभित् अव्यग्र दक्षाध्वरहर हर भगनेत्रभिद् अव्यक्त सहस्राक्ष सहस्रपाद अपवर्गप्रद अनंत तारक परमेश्वर'
echo 'शिव महेश्वर शम्भू पिनाकी शशिशेखर वामदेव विरूपाक्ष कपर्दी नीललोहित शंकर शूलपाणी खटवांगीविष्णुवल्लभ शिपिविष्ट अंबिकानाथश्रीकण्ठ भक्तवत्सल भव शर्व त्रिलोकेशशितिकण्ठ शिवाप्रिय उग्र कपाली कामारी सुरसूदन गंगाधर ललाटाक्ष महाकाल कृपानिधि भीम परशुहस्त मृगपाणी जटाधर कैलाशवासी कवची कठोर त्रिपुरांतक वृषांक वृषभारूढ़'

# echo "بسم الله"
# echo '﷽'
echo "${NC}"

source ~/powerlevel9k/powerlevel9k.zsh-theme
source "$DOTFILES_DIR/powerlevel9k-airline-theme.sh"
source "$DOTFILES_DIR/aliases.sh"
source "$DOTFILES_DIR/oh-my-zsh-aliases.sh"



HISTFILE=~/.zsh_history
HISTSIZE=50000 # how many save in file
SAVEHIST=10000 # how many load in memory (on each startup?)





# Enable Ctrl-x-e to edit command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line



EDITOR='subl -nw'

setopt auto_cd


#local host_name="%{$fg[cyan]%}$"
#local path_string="%{$fg[yellow]%}%~"
#local prompt_string="»"


#PROMPT='${host_name} ${path_string} %{$reset_color%}'

# PROMPT='%F{red}%n%f@%F{blue}%m%f %F{yellow}%1~%f %# '
#RPROMPT='[%F{yellow}%?%f]'



# Add this separator after each output:
# function echo_blank() {
#   echo "------------------------------------------------------------"
#   echo
# }
# precmd_functions+=echo_blank

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-syntax-highlighting) # zsh-syntax-highlighting very heavy for startup time
# plugins=(git)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


t() {
    cd ~/Desktop
    touch $1
    s $1
}


hg() {
    history | grep $1
}

# duck duck go search
ddg() {
    open "https://duckduckgo.com/?q=$1"
}

# ff = find filename
ff() {
    find . -iname "**$1**"
}


