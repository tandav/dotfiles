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
