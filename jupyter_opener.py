import sys
import subprocess

_  = sys.argv[1].split('/Users/tandav')[1]
_ = 'http://localhost:8888/notebooks' + _

subprocess.run(['open', _])
