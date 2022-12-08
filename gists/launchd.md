# launchd / launchctl / systemd
- [LaunchControl: Create, manage and debug launchd(8) services](http://www.soma-zone.com/LaunchControl/)
- [An extensive ZFS setup on MacOS – Yep](https://justinscholz.de/2018/06/15/an-extensive-zfs-setup-on-macos/)
- [A launchd Tutorial](http://www.launchd.info/)
- [jimbojsb/launchrocket: A Mac PrefPane to manage all your Homebrew-installed services](https://github.com/jimbojsb/launchrocket)
- [eddiezane/lunchy: A friendly wrapper for launchctl](https://github.com/eddiezane/lunchy)
- [Mac launchd and launchctl — the OSX alternative to cron | Wherever I go, there I am](https://arunxjacob.wordpress.com/2008/08/28/mac-launchd-and-launchctl-the-osx-alternative-to-cron/)
- macos launchd vs cron
- systemd vs cron
- systemd vs docker
- launchd vs systemd
- systemd - HN Search
- [launchd - YouTube Search](https://www.youtube.com/results?search_query=launchd)
- [launchctl - YouTube](https://www.youtube.com/results?search_query=launchctl)
<li><img align='center' src='https://s2.googleusercontent.com/s2/favicons?domain=www.splinter.com.au'><a href='http://www.splinter.com.au/using-launchd-to-run-a-script-every-5-mins-on/'>Using Launchd to run a script every 5 mins on a Mac | Splinter Software</a></li>

<li><img align='center' src='https://s2.googleusercontent.com/s2/favicons?domain=apple.stackexchange.com'><a href='https://apple.stackexchange.com/questions/29056/launchctl-difference-between-load-and-start-unload-and-stop/308421#308421'>launchd - Launchctl difference between load and start, unload and stop - Ask Different</a></li>
<li><img align='center' src='https://s2.googleusercontent.com/s2/favicons?domain=apple.stackexchange.com'><a href='https://apple.stackexchange.com/questions/63482/can-launchd-run-programs-more-frequently-than-every-10-seconds'>macos - Can launchd run programs more frequently than every 10 seconds? - Ask Different</a></li>


```sh
cd ~/Library/LaunchAgents
launchctl unload -w com.tandav.tools.backup.plist
launchctl load -w com.tandav.tools.backup.plist  
```
