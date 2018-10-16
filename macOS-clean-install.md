# macOS clean install

<details>
<summary>OS install</summary>

0. make all needed backups
    - `alias backup='rsync --info=all4 --delete -arR --exclude="**node_modules**" --exclude="**lib/python**" --files-from=/Users/tandav/GoogleDrive/Notes/etc/backup-dirs.txt ~ /Volumes/MyPassport/backup --log-file=/Volumes/MyPassport/backup/latest-backup.log'`
    - Desktop
    - Documents
    - Downloads
    - GoogleDrive
    - `brew list`
    - `pip3 list`
    - `~/.ssh`
    - `/Applications`
    - browser bookmarks
    - automator Services, .zshrc
1. Download macOS from app store
2. format usb-stick or sdcard (`Untitled`, `macOS Journaled`, `GUID` works well)
4. `sudo /Applications/Install\ macOS\ Mojave\ Beta.app/Contents/Resources/createinstallmedia --volume /Volumes/Untitled`
5. restart system. Hold Option key on boot.
6. choose disk utility, erase your MacOS ssd
7. choose install, wait
</details>



<details>
<summary>Prepare the system</summary>

0. turn off siri, location services, Vault encryption (maybe encrypt??)
1. settings / trackpad
    - turn on tap to click
    - faster tracking speed
    - turn off 'scroll direction natural'
    - turn on app expose 4 fingers swipe down gesture
    - via accessibility menu / trackpad / enable dragging with 3 fingers
    - maximum mouse tracking speed
1. move dock to the left and hide it, del useless apps from dock, make dock smaller
1. hide menubar
    - show battery percentage, show date and time in AM/PM format
1. Mission Control / group windows by app  `defaults write com.apple.dock expose-group-apps -bool true`
1. add russian keyboard layout
2. ⌘space to change language, ⌃space to see spotlight
3. remap caps-lock to ⌃
1. disable icloud mail, add gmail.
    - smaller email previews in Mail.app (mail-settings > Viewing > List Preview / None)
1. disable in icloud: photos, mail, reminders, notes, siri, stocks, home
1. turn on keychain sync in icloud
5. maybe reduce animations, [system preferences, google how to disable macos animations, tinker_tool]
6. edit toolbar in Safari, Finder, Mail
7. tab favicons in safari
8. Safari/Preferences/advanced/show full website address
8. login to google (also in system), github, twitter, HN, 
9. install [uBlock Origin](https://github.com/el1t/uBlock-Safari)
    - disable `show number of blocked requestson the icon`
9. view / show status bar in safari
9. Safari/Preferences/Advanced/Show Develop menu in menu bar
9. Night Shift Schedule 22-7
9. Disable display auto brigthness
    - disable slightly dim when on battery
    - turn off display after 10-15 min
    - power nap: off on battery
9. turn off screen lock (lock manually with ⌘⌃Q)
9. use plain text mode by default in `TextEdit`
9. iTunes/Preferences/Advanced/uncheck `Copy files to iTunes Media folder when adding to library`
</details>

<details>
<summary>Finder</summary>
    
- sidebar cleaning
- show folders first
- change `New Finder Window Show` from `Recents` to `your folder`
- copy backups back to system
</details>

 
<details>
<summary>Apps</summary>
    
0. install [Homebrew](https://brew.sh/)
    - if troubles with installation install <a href='https://twitter.com/tandavaya/status/1014792135546228736'><code>/Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg</code></a>

1. terminal: open new tab with `default working directory` (by default `Same working dir`)

```zsh
brew cask install telegram # probably will get an error because blocked in russia, install via AppStore
brew cask install google-backup-and-sync
brew cask install sublime-text
brew cask install torbrowser
brew cask install java # latest java
brew cask install disk-inventory-x
brew cask install arduino
brew cask install sourcetree 
brew cask install transmission
---
brew cask install eqmac
brew cask install sonic-visualiser

brew install python # latest python
brew install tldr
```
</details>

- [replace ugly sublime text icon](https://dribbble.com/shots/1827488-Final-Sublime-Text-Replacement-Icon)
- [configure sublime](https://github.com/tandav/Notes/blob/master/L1_BASE/dev/dotfiles/Preferences.sublime-settings)
- Terminal/View/Hide Marks
- install terminal theme
- install macOS Services/workflows, make shortcuts for 'em (⌘⇧L to create symlink, ⌘E for eval bash script)
- setup symlinks for dotfiles (`.zshrc`, `.gitconfig`, `.gitignore_global`)
- change font for jupyter: `~/.jupyter/custom/custom.css` 
```css
.CodeMirror pre, .output_text pre, bdi {
    font-family: Menlo; font-size: 9pt;
}

h1, h2, h3, h4, h5, h6 {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol';
}
```

<details>
<summary><code>pip3</code> global</summary>
<pre>
pip3 install numpy
pip3 install scipy
pip3 install matplotlib
pip3 install jupyter
pip3 install requests
pip3 install pyqt5
pip3 install pyqtgraph
pip3 install pyserial
pip3 install lxml
pip3 install Pillow
pip3 install Flask
sudo pip3 install --upgrade borgmatic
------------------------------------------------
pip install tqdm
pip3 install selenium
pip3 install PyOpenGL PyOpenGL_accelerate
pip3 install Cython
pip3 install PyWavelets
</pre>
</details>


------------------------------------------------

am I need `oh-my-zsh`?
maybe just change shell to `zsh`: `chsh -s /bin/zsh`

--- 
now using powerlevel9k without any installation, just `clone` and `source`
