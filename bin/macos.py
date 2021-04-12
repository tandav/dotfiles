import subprocess


def notification(text, title=None, subtitle=None, sound=False):
    code = f'display notification "{text}"'
    if title:
        code += f'with title "{title}"'
    if subtitle:
        code += f'subtitle "{subtitle}"'
    if sound:
        code += 'sound name "Glass"' # more sounds: ls /System/Library/Sounds
    cmd  = 'osascript', '-e', code
    subprocess.run(cmd)


def n_tabs(browser='Google Chrome'):
    js_code = f'''
    let browser = Application({browser!r})
    let n_tabs = 0
    for (let i = 0; i < browser.windows.length; i++)
        n_tabs += browser.windows[i].tabs.length
    '''

    cmd = 'osascript', '-l', 'JavaScript', '-e', js_code
    return int(subprocess.check_output(cmd, text=True).strip())
