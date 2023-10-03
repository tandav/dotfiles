"""
# /// pyproject
# [run]
# requires-python = ">=3.11"
# dependencies = [
#   "python-cron",
# ]
# ///
"""

import os
import runpy
from pathlib import Path
import json
import functools
import logging
import sys
import datetime
import socket
import pycron


def log_function_call(func):
    @functools.wraps(func)
    async def wrapper(*args, **kwargs):
        start_time = datetime.datetime.now()
#         logging.info(json.dumps({
        print(json.dumps({
            'timestamp': str(start_time),
            'event': 'start',
            'function': func.__module__,
        }), file=sys.stderr)
        result = await func(*args, **kwargs)
        end_time = datetime.datetime.now()
#         logging.info(json.dumps({
        print(json.dumps({
            'timestamp': str(end_time),
            'event': 'stop',
            'function': func.__module__,
            'dt_seconds': (end_time - start_time).total_seconds(),
        }), file=sys.stderr)
        return result
    return wrapper



def load_tasks():
    tasks_dir = os.environ.get('CRON_PYTHON_TASKS_DIR', Path(os.environ['dot']) / 'crontab' / socket.gethostname())
    assert tasks_dir.exists(), str(tasks_dir)
    for p in Path(tasks_dir).rglob('*.py'):
        if p.stem == '__init__':
            continue
        task = runpy.run_path(p, init_globals={'pycron': pycron}, run_name=Path(p).stem)

    pycron.scheduled_functions = [
        pycron.ScheduledFunc(
            function=log_function_call(f.function), # wrap into logging function
            cron_str=f.cron_str,
            last_run=f.last_run,
        )
        for f in pycron.scheduled_functions.copy()
    ]


def main():
    load_tasks()
    pycron.start()


if __name__ == '__main__':
    main()


# import datetime
# import logging
# import json


# class JsonFormatter (logging.Formatter):
#     def format(self, record):
#         log_dict = {}
#         # log_dict['timestamp'] = datetime.datetime.now(tz=datetime.timezone.utc).strftime('%Y-%m-%d_%H-%M-%S_%f')
#         log_dict['timestamp'] = datetime.datetime.now(tz=datetime.timezone.utc).isoformat()
#         log_dict['timestamp'] = str(datetime.datetime.now(tz=datetime.timezone.utc))
#         log_dict['level'] = record.levelname
#         message = record.getMessage()
#         message_dict = json.loads(message)
#         log_dict.update(message_dict)

#         # if isinstance(message, str):
#         #     log_dict['message'] = message
#         # elif isinstance(message, dict):
#         #     log_dict['message'].update(message)
#         # else:
#         #     raise ValueError('message must be either str or dict')
#         return json.dumps(log_dict)



# logger = logging.getLogger(__name__)
# logger.setLevel(logging.INFO)
# # handler = logging.FileHandler('cron_python.jsonl')
# handler = logging.StreamHandler()
# handler.setFormatter(JsonFormatter())
# logger.addHandler(handler)


# logger.info(json.dumps({'hello': 'world'}))
