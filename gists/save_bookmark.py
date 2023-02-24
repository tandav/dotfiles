import subprocess
from pathlib import Path
import plistlib
import string
import sys
import macos


def clean_filename(fname, maxlen=100):
    fname = fname[:maxlen]
    return ''.join(x if (x.isalnum() or x in ' .-_') else '_' for x in fname)


def run_javascript(code):
    cmd = 'osascript', '-l', 'JavaScript', '-e', code
    return subprocess.run(cmd, text=True, capture_output=True).stderr


def get_url_title():
    url, title = run_javascript('''
    const chrome = Application('Google Chrome')
    const tab    = chrome.windows[0].activeTab()
    console.log(tab.url())
    console.log(tab.title())
    ''').splitlines()
    return url, title


def ask_folder_and_filename(filename):
    path = run_javascript(string.Template('''
    const app = Application.currentApplication()
    app.includeStandardAdditions = true
    const fn = app.chooseFileName({
        withPrompt: 'Save the document as:',
        defaultName: '$filename',
    })
    console.log(fn)
    ''').substitute(filename=filename)).strip()
    path   = Path(path)
    folder = path.parent
    filename = clean_filename(path.name)
    return folder, filename


url, title = get_url_title()
filename = clean_filename(title) + '.webloc'

default = len(sys.argv) == 2 and sys.argv[1] == '--default-folder'

if default:
    folder = Path.home() / 'Documents/GoogleDrive/entrypoint/knowledge/buffer/weblocs'
else:
    folder, filename = ask_folder_and_filename(filename)

with open(folder / filename, 'wb') as f:
    plistlib.dump({'URL': url}, f)

if default:
    macos.notification(text=filename, title='saved to default')
