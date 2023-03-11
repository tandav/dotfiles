#!/usr/bin/env python3

'''
todo: maybe checkout ref without split for finding branch (will be in detached state)
maybe even checkout for commit (but for what?)

add this to ~/bin and symlink to it from each bare_repo.git/hooks
'''

import subprocess
import sys


print('================================')

old_commit, new_commit, ref = sys.stdin.read().split()

_, branch = ref.rsplit('/', maxsplit=1)

print('old_commit:', old_commit)
print('new_commit:', new_commit)
print('ref:', ref)

subprocess.check_output(['git', '--work-tree', '..', '--git-dir', '.', 'checkout', '-f', branch])
subprocess.check_output(['git', 'show', '--stat', new_commit])

# place there other build commands
print('deployed successfully')
print('================================')
