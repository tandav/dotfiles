#!/usr/bin/env python3

from pathlib import Path
import sys
import difflib

def distance(a, b, cutoff):
    s = difflib.SequenceMatcher()
    s.set_seq2(a)
    s.set_seq1(b)

    r = s.real_quick_ratio()

    if not r < cutoff:
        r = s.quick_ratio()
    if not r < cutoff:
        r = s.ratio()
    return r


query = sys.argv[1].lower()

history = (
    (Path.home() / '.zsh_history')
    .read_bytes()
    .decode(errors='ignore')
    .splitlines()
)

CUTOFF = 0.75

seen = set()
for hist_line in history:
    if hist_line in seen:
        continue

    hist_line_lower = hist_line.lower()
    close = query in hist_line_lower or distance(hist_line_lower, query, CUTOFF) > CUTOFF

    if not close:
        continue

    print(hist_line)
    seen.add(hist_line)
