# macOS Services
you can use it from menubar/services or from right-click menu

to install it run

```py
from pathlib import Path
import os

for service in Path.cwd().glob('*.workflow'):
    os.symlink(service, Path.home() / 'Library/Services' / service.name)
```


<!-- >>>>> **FAIL** for some reason symlinks workflow is not shown if your 
>>>>> put symlink in `~/Library/Services`. There should be original files
есть варик что не сразу заработает - тогда открой и закрой `Automator` по идее должно появиться
- блин вообще походу не работают / придется просто копировать вручную -->
<!-- SYMLINKS WORKS! -->

in order to edit workflow
which is not in `~/Library/Services`
use right click -> open with Automator 
instead of Automator installer (default double-click action)

