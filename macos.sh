alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

# change directory (in terminal) to the current Finder directory
function cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
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

export PATH="/usr/local/bin:${PATH}" # homebrew binaries

# for GNU Bash
# https://formulae.brew.sh/formula/bash-completion@2
# https://superuser.com/a/1393343/1129682
. "/usr/local/etc/profile.d/bash_completion.sh"
