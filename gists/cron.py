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


def log_function_call(func_name: str | None = None):
    def log_function_call_(func):
        @functools.wraps(func)
        async def wrapper(*args, **kwargs):
            start_time = datetime.datetime.now()
    #         logging.info(json.dumps({
            print(json.dumps({
                'timestamp': str(start_time),
                'event': 'start',
                'function': func_name or func.__name__,
            }), file=sys.stderr)
            result = await func(*args, **kwargs)
            end_time = datetime.datetime.now()
    #         logging.info(json.dumps({
            print(json.dumps({
                'timestamp': str(end_time),
                'event': 'stop',
                'function': func_name or func.__name__,
                'dt_seconds': (end_time - start_time).total_seconds(),
            }), file=sys.stderr)
            return result
        return wrapper
    return log_function_call_


def load_tasks(tasks_dir: str | Path):
    for p in Path(tasks_dir).rglob('*.py'):
        if p.stem == '__init__':
            continue
        task_globals = runpy.run_path(p)#, init_globals={'util': util})
        task = log_function_call(p.stem)(task_globals['main'])
        task = pycron.cron(task_globals['schedule'])(task)

def main():
    tasks_dir = os.environ.get('CRON_PYTHON_TASKS_DIR', Path(os.environ['dot']) / 'crontab' / socket.gethostname())
    assert tasks_dir.exists(), str(tasks_dir)
    load_tasks(tasks_dir)
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
