#!/usr/bin/env python3

from pipe21 import *
import sys


if len(sys.argv) != 2:
    print("pass transform functions, example: ls -l | pipe '| Map(len)'")
    raise SystemExit(1)

# print(sys.stdin | Map(len) | Pipe(list))
# cc = f'{sys.stdin} {sys.argv[1]}'
# print(cc)
# for line in eval(cc):
#     print(line)

lines = sys.stdin.read().splitlines()

for line in eval(f'{lines} {sys.argv[1]}'):
    print(line)
