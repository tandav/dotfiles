#!/bin/bash

# update repo every 4 seconds
while true; do
    git pull origin "$1"
    date
    sleep 4
done
