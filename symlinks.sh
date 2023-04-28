#!/bin/bash

set -euxo pipefail

echo "$dot"

ln -sfv "$dot/git/.gitconfig" ~
ln -sfv "$dot/git/.gitconfig-personal" ~
ln -sfv "$dot/git/.gitignore_global" ~
ln -sfv "$dot/private/.gitconfig-job" ~
ln -sfv "$dot/.tmux.conf" ~
ln -sfv "$dot/.vimrc" ~
ln -sfv "$dot/shell/.bashrc" ~
ln -sfv "$dot/shell/.bash_profile" ~
ln -sfv "$dot/shell/postactivate" ~/.cache/virtualenvs/postactivate

if [ "$HOSTNAME" == "u60" ]; then
    ln -sfv "$dot/bin/OpenJupyter.desktop" ~/.local/share/applications
    ln -sfv "$gd/selfhosted/jupyter/jupyter_notebook_config.py" ~/.jupyter/jupyter_notebook_config.py
fi
