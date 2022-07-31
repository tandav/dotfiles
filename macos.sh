#alias pc='open -a "PyCharm CE"'
alias pc='open -a PyCharm'
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