import subprocess
import datetime
import time


WIFI_NAME = 'my wifi name'
DEVICE = 'wlp3s0'


while True:

    time.sleep(10) # sleep here because of early return

    tmp = (
        subprocess
        .check_output(f'nmcli device status | grep {DEVICE}', shell=True)
        .strip()
        .decode()
        .split()
    )

    status = tmp[2]
    connection = tmp[-1]

    print(datetime.datetime.now(), connection, status)

    if (
        connection == WIFI_NAME
        and status == 'connected'
        and subprocess.call(['ping', 'google.com', '-c', '1']) == 0
    ):
        continue

    subprocess.run(['nmcli', 'c', 'up', WIFI_NAME]) # reconnect
