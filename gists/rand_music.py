import pathlib
import random
import itertools
import re
import operator
import webbrowser
import pipe21 as P


(
    pathlib.Path.home() / 'docs/knowledge/music'               # take a directory
    | P.MethodCaller('rglob', '*.md')                          # find all markdown files
    | P.FlatMap(lambda p: p | P.IterLines())                   # read all lines from all files and flatten into a single iterable
    | P.FlatMap(lambda l: re.findall(r'\[(.+)\]\((.+)\)', l))  # keep only lines with a markdown link
    | P.Map(operator.itemgetter(1))                            # extract a link
    | P.Pipe(list)                                             # convert iterable of links into a list
    | P.Pipe(random.choice)                                    # choose random link
    | P.Pipe(webbrowser.open)                                  # open link in browser
)
