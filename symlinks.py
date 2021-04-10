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

def make_symlink(symlink: Path, original: Path, overwrite=True) -> None:
    if overwrite and symlink.is_symlink():
        symlink.unlink()
    symlink.symlink_to(original) # raises FileExistsError if overwrite=False
    print(symlink, '->', original)

DOTFILES_DIR = Path(__file__).parent.absolute()

# ================================================================
# various symlinks


make_symlink(Path.home() / '.zshrc'           , DOTFILES_DIR / '.zshrc')
make_symlink(Path.home() / '.gitconfig'       , DOTFILES_DIR / '.gitconfig')
make_symlink(Path.home() / '.gitignore_global', DOTFILES_DIR / '.gitignore_global')
make_symlink(Path.home() / '.vimrc', DOTFILES_DIR / '.vimrc')
make_symlink(Path.home() / '.tmux.conf', DOTFILES_DIR / '.tmux.conf')
make_symlink(Path.home() / 'Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings', DOTFILES_DIR / 'Preferences.sublime-settings')


# ================================================================
# agents are launchctl jobs


agents = [
    f'{os.environ["pj"]}/battery_stats/com.tandav.battery_stats.plist',
    f'{os.environ["pj"]}/n_tabs/com.tandav.n_tabs.plist',
    # f'{os.environ["pj"]}/noise_level/com.tandav.noise_level.plist',
]

def reload_agent(agent):
    agent = Path(agent)
    symlink = Path.home() / 'Library/LaunchAgents' / agent.name
    make_symlink(symlink, agent)
    co(('launchctl', 'unload', '-w', str(agent)))
    co(('launchctl', 'load', '-w', str(agent)))


for agent in agents:
    reload_agent(agent)
# co('launchctl list | grep tandav', shell=True)
cmd = 'launchctl', 'list'
_ = subprocess.check_output(cmd, text=True).splitlines()
_ = [x for x in _ if 'tandav' in x]
print('\n'.join(_))

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
