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

def symlink_override(symlink, original):
    symlink = Path(symlink)
    if symlink.exists():
        symlink.unlink()
    symlink.symlink_to(original)
    print(symlink, '->', original)

DOTFILES_DIR = os.environ['DOTFILES_DIR']


# ================================================================
# various symlinks


symlink_override(Path.home() / '.zshrc'           , f'{DOTFILES_DIR}/.zshrc')
symlink_override(Path.home() / '.gitconfig'       , f'{DOTFILES_DIR}/.gitconfig')
symlink_override(Path.home() / '.gitignore_global', f'{DOTFILES_DIR}/.gitignore_global')
symlink_override(Path.home() / '.vimrc'           , f'{DOTFILES_DIR}/.zshrc')
symlink_override(Path.home() / 'Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings', f'{DOTFILES_DIR}/Preferences.sublime-settings')


# ================================================================
# agents are launchctl jobs


agents = [
    # f'{os.environ["pj"]}/battery_stats/com.tandav.battery_stats.plist',
    f'{os.environ["pj"]}/noise_level/com.tandav.noise_level.plist',
]

def reload_agent(agent):
    agent = Path(agent)
    symlink = Path.home() / 'Library/LaunchAgents' / agent.name
    symlink_override(symlink, agent)
    co(('launchctl', 'unload', '-w', str(agent)))
    co(('launchctl', 'load', '-w', str(agent)))


for agent in agents:
    reload_agent(agent)
co('launchctl list | grep tandav', shell=True)


# ================================================================
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


# ================================================================
