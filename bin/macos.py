import subprocess
import string
import json


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


def n_tabs(browser='Google Chrome', n_windows=False):
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


def tabs(browser='Google Chrome'):
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
