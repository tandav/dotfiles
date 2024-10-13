#!/bin/bash

set -euxo pipefail

echo "$dot"

ln -sfv "$dot/git/.gitconfig" ~
ln -sfv "$dot/.tmux.conf" ~
ln -sfv "$dot/shell/.profile" ~
ln -sfv "$dot/shell/.bashrc" ~
ln -sfv "$dot/shell/postactivate" ~/.cache/virtualenvs/postactivate
ln -sfv "$dot/private/ssh_config" ~/.ssh/config
ln -sfv "$dot/private/ssh_config.d" ~/.ssh/ssh_config.d

if [ "$HOSTNAME" == "u60" ]; then
    ln -sfv "$dot/bin/OpenJupyter.desktop" ~/.local/share/applications
    ln -sfv "$gd/selfhosted/jupyter/jupyter_notebook_config.py" ~/.jupyter/jupyter_notebook_config.py
fi

if [ "$HOSTNAME" == "mbp16.local" ]; then
    ln -sfv "$dot/sublime-text/horisontal-line.sublime-snippet" "/Users/tandav/Library/Application Support/Sublime Text 3/Packages/User"
    ln -sfv "$dot/sublime-text/Preferences.sublime-settings" "/Users/tandav/Library/Application Support/Sublime Text 3/Packages/User"
fi

source "$dot/private/symlinks.sh"
