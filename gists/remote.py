import subprocess
import pathlib
import shutil


host    = None
folder  = ''
python  = None
spark   = None


def run(command, from_dir=None):
    if from_dir:
        _command = ['ssh', host, f'cd {from_dir};'] + command
    else:
        _command = ['ssh', host] + command
    print(' '.join(_command))
    subprocess.check_output(_command)


def upload_file(local_path, remote_path):
    print(f'upload_file {local_path} {remote_path}')
    subprocess.run([
       'rsync',
        '-azvhP',
        local_path,
        host + ':' + remote_path,
    ])


def upload_dir(local_dir, remote_dir):
    subprocess.check_output(['rsync', '-r', '-azvhP', str(local_dir), host + ':' + remote_dir])
    subprocess.check_output(['osascript', '-e', f'display notification "{local_dir.name}" with title "Upload Done: {host}"'])


def upload_dir_to_root(local_dir):
    upload_dir(local_dir, '')


def upload_dir_to_root_with_payload(local_dir, payload):
    for p in payload:
        shutil.copyfile(p, local_dir / p.name)

    upload_dir_to_root(local_dir)

    for p in payload:
        (local_dir / p.name).unlink()


# def upload_many(local_paths):
#     local_paths = [str(lp) for lp in local_paths] # converts to str from pathlib
#     subprocess.run(['rsync', '-r', '-azvhP'] + local_paths + [host + ':' + str(folder)])


def upload_dir_content(local_content_dir, remote_folder):
    '''
    uploads folder content
    (but not the directory itself)
    '''
    print(f'upload_dir_content {local_content_dir} {remote_folder}')
    upload_dir(local_content_dir + '/')


def pyspark(command):
    print(f'pyspark {command}')
    run(spark + command)


def download_file(remote_file_path, local_file_path):
    subprocess.check_output([
        'rsync',
        '-azvhP',
        host + ':' + remote_file_path,
        local_file_path,
    ])


def download_folder(remote_file_path, local_file_path):
    subprocess.check_output([
        'rsync',
        '-r',
        '-azvhP',
        host + ':' + remote_file_path,
        local_file_path,
    ])


def upload_my_modules(my_modules_local='/Users/tandav/Documents/spaces/python/my_modules'):
    '''
    you should add to .bashrc on remote:
    export PYTHONPATH=~/my_modules
    '''
    upload_dir(my_modules_local)


# def run_code(main='main.py', spark=False):
#     if spark:
#         pyspark([folder + '/' + main])
#     else:
#         run([python, folder + '/' + main])


# def run_folder(main='main.py', spark=False):
#     if spark:
#         pyspark([folder + '/' + main])
#     else:
#         run([python, main], from_dir=folder)


# def run_folder(main='main.py', spark=False):
#     if spark:
#         pyspark([folder + '/' + main])
#     else:
#         run([python, main], from_dir=folder)
#

def tmux_command(command, session='my'):
    run([f'tmux send -t {session} "{command}" ENTER'])


# def download_report(report_file='report.txt'):
#     download_file(
#         folder + report_file,
#         report_file,
#     )
