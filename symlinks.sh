DOTFILES_DIR=$HOME/docs/dotfiles
echo $DOTFILES_DIR

ln -sf "$DOTFILES_DIR/.gitconfig" ~
ln -sf "$DOTFILES_DIR/.gitconfig-personal" ~
ln -sf "$DOTFILES_DIR/private/.gitconfig-job" ~
ln -sf "$DOTFILES_DIR/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/.tmux.conf" ~
ln -sf "$DOTFILES_DIR/.vimrc" ~
ln -sf "$DOTFILES_DIR/.bashrc" ~
ln -sf "$DOTFILES_DIR/.bash_profile" ~
# ln -sf "$DOTFILES_DIR/.bash_history" ~
ln -sf "$DOTFILES_DIR/private/.pypirc" ~

mkdir -p "$HOME/.config/pip"
ln -sf "$DOTFILES_DIR/private/pip.conf" "$HOME/.config/pip/pip.conf"
