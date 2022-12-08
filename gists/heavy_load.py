import numpy as np
import datetime
import sys

n = int(sys.argv[1])

with open('dt.txt', 'a') as f:
    while True:
        t0 = datetime.datetime.now()
        a = np.random.random((n, n)).astype('float32')
        b = np.random.random((n, n)).astype('float32')
        c = sum(a @ b)
        t1 = datetime.datetime.now()
        dt = (t1 - t0).total_seconds()
        s = f'TS: {t1} DT: {dt}'
        print(s)
        print(s, file=f)