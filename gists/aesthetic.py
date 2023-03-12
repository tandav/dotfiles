#!/usr/bin/env python3
import sys

def aesthetic(s: str) -> None:
    '''
    A E S T H E T I C
    E E
    S   S
    T     T
    H       H
    E         E
    T           T
    I             I
    C               C
    '''
    s = s.upper()
    for i, c in enumerate(s):
        if i == 0:
            print(' '.join(s))
            continue
        line = [' '] * len(s)
        line[0] = c
        line[i] = c
        print(' '.join(line))

# aesthetic('aesthetic')
aesthetic(sys.argv[1])
