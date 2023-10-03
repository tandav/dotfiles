import shlex
import subprocess
import pycron


@pycron.cron('0/1 * * * * ')
async def main(timestamp):
    cmd = '/Users/tandav/.cache/virtualenvs/notes-cron-export/bin/python -m cron_export'
    subprocess.run(shlex.split(cmd), cwd='/Users/tandav/docs/notes')
