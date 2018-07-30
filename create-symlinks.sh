# this script creates symlinks for my dotfiles
# actual files stored in my this repo
# system files are symlinking to this repo
# THIS FILE IS UNDONE
# there is other another solutions:
# - [A simple way to manage dotfiles with git without silly symlinks and special tools](https://gist.github.com/lonetwin/9636897)
# - [Ask HN: What do you use to manage dotfiles? | Hacker News](https://news.ycombinator.com/item?id=11070797)

ln -sf "$(pwd)/zshrc" ~/.zshrc
ln -sf "$(pwd)/vimrc" ~/.vimrc
ln -sf "$(pwd)/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
ln -sf "$(pwd)/gitconfig" ~/.gitconfig
ln -sf "$(pwd)/gitignore_global" ~/.gitignore_global
