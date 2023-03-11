import subprocess
import shlex


commits = subprocess.check_output(shlex.split('git rev-list --all')).split()
print(commits)
