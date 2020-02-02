import pathlib
import sys
import subprocess

_ = pathlib.Path(sys.argv[1])
_ = _.absolute()
_ = str(_)
_  = _.split('/Users/tandav')[1]
_ = 'http://localhost:8888/notebooks' + _

subprocess.run(['open', _])
