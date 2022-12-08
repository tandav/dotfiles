import subprocess
import re
import macos


router = subprocess.check_output('route get default | grep gateway', shell=True, text=True).strip().split()[1]
host = router
PATTERN = r'[\d|\.]+(?=%)'
NOTIFICATION_TRESHOLD = 50


while True:
    out = subprocess.check_output(('sudo', 'ping', '-f', host, '-c', '1000'), text=True)
    a, b = out.splitlines()[-2:]
    print(b, a, sep=' | ')
    a = a.rsplit(',', maxsplit=1)[1].strip()
    b = b.split(maxsplit=1)[1]
    loss = float(re.search(PATTERN, a).group())

    if loss > NOTIFICATION_TRESHOLD:
        macos.notification(text=b, title='poor connection', subtitle=a)
