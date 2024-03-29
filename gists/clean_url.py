#!/usr/bin/env python3

import sys


import subprocess
from urllib.parse import urlparse, urlunparse, parse_qs, urlencode


def parse_markdown_link(link: str) -> tuple[str]:
    '''returns (title, url) tuple'''
    return re.search('\[(.*)\]\((.*)\)', link).groups()

def to_markdown_link(title: str, url: str) -> str:
    return f'- [{title}]({url})'



def clean(url, allowed_params=('q', 'tbm'), drop_https=True, pass_no_google=False):
    o = urlparse(url)

    if o.netloc != 'www.google.com':
        if pass_no_google:
            return url
        raise ValueError('pass google search url or set pass_no_google=True')

    params = parse_qs(o.query)
    clean_params = {p: params[p] for p in params.keys() & allowed_params}
    clean_url = urlunparse(o._replace(query=urlencode(clean_params, doseq=True)))

    if drop_https: # drop https:// scheme part
        clean_url = clean_url.partition('google.com')
        clean_url = ''.join(clean_url[1:])

    return clean_url


if len(sys.argv) == 2:
    cleaned = clean(sys.argv[1])
    print(cleaned)
    print('also copied to clipboard')
    subprocess.run('pbcopy', input=cleaned, text=True)
elif len(sys.argv) == 3:
    from pathlib import Path
    import re
    import shutil
    import random
    import string

    assert sys.argv[1] == '-f', f'unknown param: {sys.argv[1]}'
    p = Path(sys.argv[2])
    assert p.exists(), 'file does not exists'


    backup = Path('/tmp') / (p.stem + '-' + ''.join(random.sample(string.ascii_letters, 5)) + p.suffix)
    shutil.copy(p, backup)
    print(f'backed up to', backup)
    print('cleaning file', p)

    lines = p.read_text().splitlines()

    with open(p, 'w') as f:
        for line in lines:
            # print(line)
            title, url = parse_markdown_link(line)
            url = clean(url, drop_https=False, pass_no_google=True)
            line = to_markdown_link(title, url)
            print(line, file=f)
        # print('=' * 50)
    print('done')
else:
    raise ValueError('wrong arguments, pass either url or -f file')
