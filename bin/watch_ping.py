#!/Users/tandav/.virtualenvs/ping/bin/python



# this script is tested only on macOS 13.0.1 (Ventura) using /sbin/ping command
#
# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>PingMonitor</xbar.title>
#  <xbar.version>v0.0.1</xbar.version>
#  <xbar.author>Alexander Rodionov</xbar.author>
#  <xbar.author.github>tandav</xbar.author.github>
#  <xbar.desc>ping every 5 seconds and set network status to the menubar</xbar.desc>
#  <xbar.dependencies>python</xbar.dependencies>
#  <xbar.abouturl>https://github.com/tandav/dotfiles/bin/watch_ping.py</xbar.abouturl>


import time
import shlex
import subprocess
import datetime
import logging
import json
import random
import dataclasses
import sys


@dataclasses.dataclass(frozen=True)
class ProcessResult:
    returncode: int
    stdout: str
    stderr: str

    # def to_dict(self):
        # return self.


class JsonFormatter (logging.Formatter):
    def format(self, record):
        log_dict = {}
        log_dict['timestamp'] = datetime.datetime.utcnow().isoformat()
        log_dict['level'] = record.levelname
        message = record.getMessage()
        message_dict = json.loads(message)
        log_dict.update(message_dict)

        # if isinstance(message, str):
        #     log_dict['message'] = message
        # elif isinstance(message, dict):
        #     log_dict['message'].update(message)
        # else:
        #     raise ValueError('message must be either str or dict')
        return json.dumps(log_dict)


logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
handler = logging.FileHandler('/Users/tandav/Desktop/ping-logs.jsonl')
handler.setFormatter(JsonFormatter())
logger.addHandler(handler)


# logger.info(json.dumps({'test': '42'}))


def log_message(
    message: str,
) -> None:
    import macos
    print(message)
    logger.info(message)
    macos.notification(text=datetime.datetime.utcnow().isoformat(), title=message)


def ping(
    host: str = '1.1.1.1',
    count: int = 3,
    waittime_milliseconds: int = 1000,
) -> ProcessResult:
    """
    from `man ping`:
    EXIT STATUS
     The ping utility exits with one of the following values:

     0       At least one response was heard from the specified host.

     2       The transmission was successful but no responses were received.

     any other value
             An error occurred.  These values are defined in <sysexits.h>.
    """
    cmd = shlex.split(f'ping -c {count} -W {waittime_milliseconds} {host}')
    p = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    return ProcessResult(returncode=p.returncode, stdout=p.stdout, stderr=p.stderr)


def watch(sleep_seconds: int = 1):
    is_connected = False
    while True:
        p = ping()
        if not is_connected and p.returncode == 0:
            log_message(json.dumps(dataclasses.asdict(p) | {'message': 'network connection established ✅'}))
            is_connected = True
        elif is_connected and p.returncode != 0:
            log_message(json.dumps(dataclasses.asdict(p) | {'message': 'network connection broken ❌'}))
            is_connected = False
        time.sleep(sleep_seconds)


def run_once():
    from redis import Redis
    redis = Redis.from_url('redis://localhost', decode_responses=True)

    p = ping()
    counter = redis.incr('ping_counter')
    t_now = time.time()
    t = redis.get('ping_t')
    if t is None:
        t = t_now
    else:
        t = float(t)

    dt = t_now - t
    if p.returncode == 0:
        print(f'network {counter} ✅')
    else:
        print(f'network {counter} ❌')
    print('---')
    print(f'{dt=:4.1f} seconds')
    # print('---')
    # print(f'{counter=}')
    redis.set('ping_t', t_now)


if __name__ == '__main__':
    if len(sys.argv) == 2 and sys.argv[1] == 'watch':
        watch()
    elif len(sys.argv) == 1:
        run_once()
    else:
        raise ValueError
