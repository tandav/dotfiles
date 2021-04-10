import sys
import subprocess
import pickle

with open(sys.argv[1], 'rb') as fd:
    obj = pickle.load(fd)

EDITOR = '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'

cmd = EDITOR, '--new-window'
subprocess.run(cmd, input=repr(obj)[:1000], text=True)
