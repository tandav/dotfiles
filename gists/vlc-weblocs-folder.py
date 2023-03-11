# python3 vlc-weblocs-folder.py indian/vedic/ | xargs open -a VLC

from glob import glob
import sys
import plistlib

if len(sys.argv) == 1:
    print('select folder with weblocs')
    sys.exit(2)


if len(sys.argv) == 2:

    for webloc in glob(sys.argv[1] + '**.webloc'):
        print(plistlib.readPlist(webloc)['URL'])
