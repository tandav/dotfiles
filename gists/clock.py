from datetime import datetime
from time import sleep
while True:
    print(datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S.%f')[:-3], end='\r')
    sleep(0.001)
