import io
from pathlib import Path
import subprocess
import requests
import PIL.Image
import PIL.ImageFilter
import sys

# display resolution
# width, height = 1440, 900
width, height = 3072, 1920

# x2 for better look (because jpg)
width  *= 2
height *= 2

img_file = Path('blur.jpg').absolute()
if len(sys.argv) == 1:
    _ = f'https://source.unsplash.com/random/{width}x{height}'
    _ = requests.get(_).content
    _ = io.BytesIO(_)
else:
    _ = sys.argv[1]
_ = PIL.Image.open(_)
radius = 60 if len(sys.argv) == 2 else int(sys.argv[2])
_ = _.filter(PIL.ImageFilter.GaussianBlur(radius=radius))
_.save(img_file)

set_wallpaper = f'''
tell application "System Events"
    tell every desktop
        set picture to "{img_file}"
    end tell
end tell
'''

subprocess.run(['osascript', '-e', set_wallpaper])
subprocess.run(['killall', 'Dock']) # sometimes you need this
