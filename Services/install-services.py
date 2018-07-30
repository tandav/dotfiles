import os
from os.path import expanduser
from glob import glob

services = glob('*.workflow')

sf = expanduser('~/Library/Services') # macOS user's Services folder
# sf = expanduser('~/Desktop') # macOS user's Services folder

for service in services:
    os.symlink(os.path.abspath(service), sf + '/' + service)
    print(f'created symlink: {service} -> {sf}/{service}')

# os.mkdir('~/Desktop/ss')

# from os.path import expanduser
# home = expanduser('~')
# home = expanduser('~/Library/Services')

# print(home)
