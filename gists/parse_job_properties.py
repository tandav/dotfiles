from pathlib import Path

config = dict()

for line in Path('job.properties').read_text().splitlines():
    if line == '' or line.startswith('#'):
        continue
    k, v = line.split('=', maxsplit=1)
    config[k] = v    
