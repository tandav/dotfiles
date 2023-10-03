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


def make_task(p: Path):
    task_globals = runpy.run_path(p)
    schedule = task_globals['schedule']
    function_name = p.name
    function = task_globals['main']

    @pycron.cron(schedule)
    async def task_logged(timestamp: datetime.datetime):
        start_time = datetime.datetime.now()
        result = await function(timestamp)
        end_time = datetime.datetime.now()
        print(json.dumps({'timestamp': str(start_time), 'event': 'start', 'function': function_name}), file=sys.stderr)
        print(json.dumps({'timestamp': str(end_time), 'event': 'stop', 'function': function_name, 'dt_seconds': (end_time - start_time).total_seconds()}), file=sys.stderr)
    return task_logged


def load_tasks(tasks_dir: str | Path):
    for p in Path(tasks_dir).rglob('*.py'):
        if p.stem == '__init__':
            continue
        task = make_task(p)

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
