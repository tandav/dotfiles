from pathlib import Path
import subprocess
import argparse


def virtualenvs(venvs_dir: Path):
    for path in venvs_dir.iterdir():
        if path.is_dir():
            yield path


def main(venvs_dir: str) -> None:
    venvs_dir = Path(venvs_dir).expanduser()
    for venv in virtualenvs(venvs_dir):
        python = venv / 'bin' / 'python'
        print(python)
        subprocess.check_call([python, '-m', 'pip', 'install', '--upgrade', 'pip'])


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--venvs-dir', type=str, default='~/.virtualenvs')
    parsed_args = parser.parse_args()
    main(**vars(parsed_args))
