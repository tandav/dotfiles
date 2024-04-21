#!/usr/bin/env python3

import datetime
from pathlib import Path
import os
import io
import sys
import shlex
import requests
import subprocess


import subprocess
import string
import json
import os


def notification(text, title=None, subtitle=None, sound=False):
    """
    https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/DisplayNotifications.html
    you can also use `say hello`
    """
    code = f'display notification "{text}"'
    if title:
        code += f'with title "{title}"'
    if subtitle:
        code += f'subtitle "{subtitle}"'
    if sound:
        # more sounds: ls /System/Library/Sounds
        # code += 'sound name "Glass"'
        code += 'sound name "only_bad_soundname_works_for_some_reason"' # breaks after Catalina -> Ventura update
    cmd  = 'osascript', '-e', code
    subprocess.run(cmd)


def n_tabs(browser=os.environ.get('BROWSER', 'Google Chrome'), n_windows=False):
    js_code = f'''
    let browser = Application({browser!r})
    let n_tabs = 0
    let n_windows = browser.windows.length
    for (let i = 0; i < n_windows; i++)
        n_tabs += browser.windows[i].tabs.length
    '''

    # final value, returned to the caller
    if n_windows:
        js_code += 'out = [n_tabs, n_windows]\n'
        cmd = 'osascript', '-l', 'JavaScript', '-e', js_code
        return [int(x) for x in  subprocess.check_output(cmd, text=True).strip().split(', ')]

    else:
        js_code += 'out = n_tabs\n'
        cmd = 'osascript', '-l', 'JavaScript', '-e', js_code
        return int(subprocess.check_output(cmd, text=True).strip())


def tabs(browser=os.environ.get('BROWSER', 'Google Chrome')):
    js_code = string.Template('''
    let browser = Application('$browser')
    if (browser.running()) {
        let tabs = []
        for (let i = 0; i < browser.windows.length; i++) {
            let window = []
            for (let j = 0; j < browser.windows[i].tabs.length; j++) {
                let tab_name = browser.windows[i].tabs[j].name()
                let tab_url  = browser.windows[i].tabs[j].url()
                window.push([tab_name, tab_url])
            }
            tabs.push(window)
        }
        out = JSON.stringify(tabs)
    } else {
        out = "application is not running"
    }
    ''').substitute(browser=browser)

    cmd = 'osascript', '-l', 'JavaScript', '-e', js_code
    out = subprocess.check_output(cmd, text=True).strip()
    if out == 'application is not running':
        print(browser, out)
        return []
    tabs = json.loads(out)
    return tabs


def main():
    tabs_dir = Path.home() / 'docs/knowledge-private/tabs'
    filename = tabs_dir / f"tabs-{datetime.datetime.now().strftime('%Y-%m-%d-%H%M%S')}.md"


    with open(filename, 'w') as f:
        for window in tabs():
            for title, url in window:
                if not title:
                    title = url
                print(f'- [{title}]({url})', file=f)
            print('\n' + '-' * 60 + '\n', file=f)

    subprocess.run(('open', filename))


    # is_tmp = len(sys.argv) == 2 and sys.argv[1] == 'tmp'

    # if is_tmp:
    #     # filename = filename / 'tmp/README.md'
    #     f = io.StringIO()
    #     print('# tabs dump', file=f)
    # else:
    #     filename = filename / f"tabs-{datetime.datetime.now().strftime('%Y-%m-%d-%H%M%S')}.md"
    #     f = open(filename, 'w')




    # if is_tmp:
    #     r = requests.post('http://0.0.0.0:5003/notes/144/edit/', json={'text': f.getvalue(), 'url': None, 'tags': ['tools']})
    #     assert r.ok, r.json()

    #     git_dir = filename / 'tmp'
    #     (git_dir / 'README.md').write_text(f.getvalue())
    #     subprocess.check_call(shlex.split('git add .'), cwd=git_dir)
    #     subprocess.check_call(shlex.split('git commit --amend -m _'), cwd=git_dir)
    #     subprocess.check_call(shlex.split('git push --force origin HEAD'), cwd=git_dir)
    # else:
    #     f.close()
    #     subprocess.run(('open', filename))

if __name__ == '__main__':
    main()
