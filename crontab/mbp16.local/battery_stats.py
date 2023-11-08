
import shlex
import subprocess
import pycron


# UTC
@pycron.cron('0 4 * * *')
async def main(timestamp):
    cmd = '/Users/tandav/.cache/virtualenvs/battery-stats/bin/python /Users/tandav/docs/_archive/battery_stats/battery_stats.py'
    subprocess.run(shlex.split(cmd), cwd='/Users/tandav/docs/_archive/battery_stats')
