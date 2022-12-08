import subprocess
import concurrent.futures
from pathlib import Path
import time
import macos

REMOTE = 'or1' # ~/.ssh/config
# FOLDER = Path.home() / 'GoogleDrive'
# FOLDER = Path.home() / 'Desktop/cofein'
FOLDER = Path.home() / 'Desktop/xad'
ZIPFILE = FOLDER.with_suffix('.zip')


def zip():
    macos.notification('zipping...', title='Backup Started')
    subprocess.run(('zip', '-r', ZIPFILE, str(FOLDER)))
    size = ZIPFILE.stat().st_size
    return size


def upload():
    macos.notification(f'🌎⬆️ uploading to remote... 0%', title='Zipping Done', subtitle=ZIPFILE.stat().st_size)
    subprocess.run(('rsync', ZIPFILE, f'{REMOTE}:~'))


def remote_size():
    '''
    works on GNU (eg Ubuntu), on BSD (eg macOS it's different) https://unix.stackexchange.com/questions/16640

    with filenames
    stat --printf="%n %s\n" *xad.zip*

    shopt -s dotglob (match files that starts with dot)

    '''
    # return int(subprocess.check_output(('ssh', REMOTE, 'stat', '--printf="%s"', ZIPFILE.name), text=True))
    # return int(subprocess.check_output(('ssh', REMOTE, 'stat', '--printf="%s"', f'.{ZIPFILE.name}*'), text=True))
    return int(subprocess.check_output(('ssh', REMOTE, f'stat --printf="%s\n" *{ZIPFILE.name}*'), text=True))


def sleep():
    subprocess.run(('sleep', '10'))

print(remote_size())

# size = zip()
# # size = ZIPFILE.stat().st_size
#
# with concurrent.futures.ThreadPoolExecutor() as pool:
#     upload_task = pool.submit(upload)
#
#     while not upload_task.done():
#         time.sleep(4)
#         size_remote = remote_size()
#         percent = int(size_remote / size * 100)
#         print(size_remote, size, size_remote / size, percent, '%')
#         macos.notification(f'{percent}%', title='🌎⬆️ uploading to remote...', subtitle=ZIPFILE.stat().st_size)
#
#
# macos.notification('🙂✅', title='Backup Done')
