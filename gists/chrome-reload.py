import subprocess
import time

cmd = 'osascript', '-l', 'JavaScript', '-e', 'Application("Google Chrome").windows[0].activeTab().reload()'

while True:
    subprocess.run(cmd)
    time.sleep(2)
