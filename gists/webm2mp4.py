import pathlib
import subprocess
import sys


if len(sys.argv) == 2:
    subprocess.run(['curl', '-O', sys.argv[1]])

for webm in pathlib.Path.cwd().glob('*.webm'):
    subprocess.run(['ffmpeg', '-i', webm, webm.with_suffix('.mp4')])
    webm.unlink()
