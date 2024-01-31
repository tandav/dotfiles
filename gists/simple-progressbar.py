'''
>>> 20/20
'''

from time import sleep

n = 20
for i in range(n):
    print(f'{i + 1}/{n}', end='\r')
    sleep(0.2)
