#!/bin/bash

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# change directory (in terminal) to the current Finder directory
function cdf() {
    target=$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    if [ "$target" != "" ]; then
        cd "$target" || exit # exit if cd fails (shellcheck)
    else
        echo 'No Finder window found' >&2
    fi
}

brewup() {
    brew update
    brew upgrade
    brew cleanup --prune-prefix
    brew doctor
}

# Setting PATH for Python 3.11
# The original version is saved in .bash_profile.pysave
# export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:${PATH}"
# export PATH=/usr/local/opt/python@3.10/bin:$PATH

export PATH="/usr/local/bin:${PATH}" # homebrew binaries

# for GNU Bash
# https://formulae.brew.sh/formula/bash-completion@2
# https://superuser.com/a/1393343/1129682
. "/usr/local/etc/profile.d/bash_completion.sh"

# coreutils: macOS -> gnu
# export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

# python
export KERNELS_DIR=~/Library/Jupyter/kernels
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.10/bin/python3.10
# export VIRTUALENVWRAPPER_PYTHON=/usr/local/opt/python@3.11/bin/python3.11
export VIRTUALENVWRAPPER_PYTHON="/Library/Frameworks/Python.framework/Versions/3.11/bin/python3.11"

# virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh
