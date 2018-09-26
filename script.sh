#!/bin/bash

# date >> /Users/tandav/Desktop/log.txt
# sleep 2

# crontab every 7 minutes
# */7 * * * * bash /Users/tandav/Documents/108/dotfiles/script.sh

connected="$(system_profiler SPPowerDataType | grep "Connected" | awk '{print $2}')" # power adapter or battery check


if [ $connected = 'Yes' ]; then
    osascript -e 'display notification "borg" with title "Start Backing Up..." sound name "Pong"'

    /usr/local/bin/borgmatic --config /Users/tandav/Documents/108/dotfiles/borgmatic-config.yaml
    # /usr/local/bin/borgmatic --config /Users/tandav/Documents/108/dotfiles/borgmatic-config.yaml --verbosity 2
    # /usr/local/bin/borgmatic --help
    # cat ~/Documents/108/dotfiles/borgmatic-config.yaml > ~/Desktop/log.txt
    # whoami >> ~/Desktop/log.txt
    EXIT_STATUS=$?

    if [ $EXIT_STATUS -eq 0 ]; then
        osascript -e 'display notification "borg" with title "Backup Complete" sound name "Pong"'
    else
        echo "$EXIT_STATUS" >> /Users/tandav/Desktop/log.txt
        osascript -e 'display notification "borg" with title "Backup Failed" sound name "Pong"'
    fi

else
    osascript -e 'display notification "borg" with title "On battery, backup skipped" sound name "Pong"'
fi    






