#!/usr/bin/env python3

# import subprocess
import sys
import webbrowser
from pathlib import Path


absolute = Path(sys.argv[1])
path = str(absolute).removeprefix(str(Path.home()))
url = 'http://localhost:8888/notebooks' + path
webbrowser.open(url)
# subprocess.run(['open', url])
