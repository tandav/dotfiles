# this script creates symlinks for my dotfiles
# actual files stored in my this repo
# system files are symlinking to this repo
# THIS FILE IS UNDONE
# there is other another solutions:
# - [A simple way to manage dotfiles with git without silly symlinks and special tools](https://gist.github.com/lonetwin/9636897)
# - [Ask HN: What do you use to manage dotfiles? | Hacker News](https://news.ycombinator.com/item?id=11070797)

from pathlib import Path
import os
import subprocess

def co(cmd, shell=False): print(subprocess.check_output(cmd, shell=shell, text=True))

# cd ~
# ln -sf $DOTFILES_DIR/.zshrc
# ln -sf $DOTFILES_DIR/.gitconfig
# ln -sf $DOTFILES_DIR/.gitignore_global
# ln -sf $DOTFILES_DIR/.vimrc
# ln -sf $DOTFILES_DIR/Preferences.sublime-settings "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"

# ln -sf $pj/battery_stats/com.tandav.battery_stats.plist ~/Library/LaunchAgents



agents = [
    f'{os.environ["pj"]}/battery_stats/com.tandav.battery_stats.plist',
]

def reload_agent(agent):
    agent = Path(agent)
    symlink = Path.home() / 'Library/LaunchAgents' / agent.name
    if symlink.exists():
        symlink.unlink()
    print(symlink, '->', agent)
    symlink.symlink_to(agent)
    co(('launchctl', 'unload', '-w', str(agent)))
    co(('launchctl', 'load', '-w', str(agent)))


for agent in agents:
    reload_agent(agent)
co('launchctl list | grep tandav', shell=True)



# Quick Actions are workflows that may be added to Finder, Touch Bar and the Services menu. 
quick_actions = [
]

def reload_quick_actions():
    ...







# for quick_action in Path.cwd().glob('*.workflow'):
#     symlink = Path.home() / 'Library/Services' / quick_action.name
#     print(symlink, '->', quick_action)
#     if symlink.exists() or symlink.is_symlink(): # bug
#         symlink.unlink()
#     symlink.symlink_to(quick_action)
