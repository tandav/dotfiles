#!/bin/bash

echo "$dot"

ln -sfv "$dot/git/.gitconfig" ~
ln -sfv "$dot/git/.gitconfig-personal" ~
ln -sfv "$dot/git/.gitignore_global" ~
ln -sfv "$dot/private/.gitconfig-job" ~
ln -sfv "$dot/.tmux.conf" ~
ln -sfv "$dot/.vimrc" ~
ln -sfv "$dot/.bashrc" ~
ln -sfv "$dot/.bash_profile" ~
ln -sfv "$dot/private/.pypirc" ~
ln -sfv "$gd/selfhosted/jupyter/jupyter_notebook_config.py" ~/.jupyter/jupyter_notebook_config.py

mkdir -p "$HOME/.config/pip"
ln -sfv "$dot/private/pip.conf" "$HOME/.config/pip/pip.conf"
