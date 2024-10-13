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

export PATH="/usr/local/bin:${PATH}" # homebrew binaries
export PATH="/usr/local/sbin:$PATH"  # homebrew binaries
# for GNU Bash
# https://formulae.brew.sh/formula/bash-completion@2
# https://superuser.com/a/1393343/1129682
. "/usr/local/etc/profile.d/bash_completion.sh"

# coreutils: macOS -> gnu
# export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
export PATH=$PATH:~/.cargo/bin

# python
export KERNELS_DIR=~/Library/Jupyter/kernels

# virtualenvwrapper
export WORKON_HOME=~/.cache/virtualenvs
export VIRTUALENVWRAPPER_PYTHON="/Users/tandav/.cache/virtualenvs/virtualenvwrapper/bin/python"
export VIRTUALENVWRAPPER_VIRTUALENV=~/.cache/virtualenvs/virtualenvwrapper/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh
