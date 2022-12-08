import subprocess
import time
import random
import shlex

while True:
    cmd = f'tmux display-message -d 500 {random.random()}'
    subprocess.check_call(shlex.split(cmd))
    time.sleep(1)
