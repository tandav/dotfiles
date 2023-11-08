import shlex
import subprocess
import pycron


@pycron.cron('0/5 * * * *')
async def main(timestamp):
    cmd = 'cp -p /Users/tandav/docs/dotfiles/private/tandav.kdbx "/Users/tandav/Library/Mobile Documents/com~apple~CloudDocs"'
    subprocess.run(shlex.split(cmd))
