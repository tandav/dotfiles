'''
# macOS Services
you can use it from menubar/services or from right-click menu


<!-- >>>>> **FAIL** for some reason symlinks workflow is not shown if your 
>>>>> put symlink in `~/Library/Services`. There should be original files
есть варик что не сразу заработает - тогда открой и закрой `Automator` по идее должно появиться
- блин вообще походу не работают / придется просто копировать вручную -->
<!-- SYMLINKS WORKS! -->

in order to edit workflow
which is not in `~/Library/Services`
use right click -> open with Automator 
instead of Automator installer (default double-click action)
'''


from pathlib import Path


for service in Path.cwd().glob('*.workflow'):
    symlink = Path.home() / 'Library/Services' / service.name
    print(symlink, '->', service)
    if symlink.exists() or symlink.is_symlink(): # bug
        symlink.unlink()
    symlink.symlink_to(service)


