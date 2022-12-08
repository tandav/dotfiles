from pathlib import Path

stats = []
for p in Path.home().rglob('*'):
    mb = p.stat().st_size / 1e6
    if mb > 1:
        stats.append((mb, p))
        
for mb, p in sorted(stats, reverse=True):
    print('{:>7.2f} MB {}'.format(mb, p))
