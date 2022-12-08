'''
https://gist.github.com/seebk/9291836
https://www.zufallsheld.de/2014/01/25/python-backup-script-revisited
'''

import os
import sys
from subprocess import run

dirs = [
    os.path.expanduser('~/Desktop'),
    os.path.expanduser('~/Documents'),
    os.path.expanduser('~/Downloads'),
    os.path.expanduser('~/GoogleDrive'),
    os.path.expanduser('~/.ssh'),
]




disks = [
    '/Volumes/MyPassport',
    '/Volumes/SanDisk64GB',
]

for disk in disks:
    if os.path.exists(disk):
        destination = disk + '/backups'
        logfile = destination + '/latest-backup.log'
        
        print('backing up to', destination)
        for dir in dirs:
            run(['rsync', '-a', '--delete', '--verbose', '--log-file', logfile, dir, destination])

    else:
        print(f'disk {disk} is not connected')

