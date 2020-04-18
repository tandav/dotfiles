from glob import glob
import plistlib
import sys
import os

dir = sys.argv[1]

for webloc in glob(dir + '/*.webloc'):

    title = os.path.splitext(
            os.path.basename(webloc)
    )[0]
    url = plistlib.readPlist(webloc)['URL']
    domain = url.split('://')[1].split('/')[0]
    print(f"<li><img align='center' src='https://s2.googleusercontent.com/s2/favicons?domain={domain}'><a href='{url}'>{title}</a></li>")
