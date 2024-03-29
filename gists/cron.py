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
import humanize
import sys
import datetime
import socket
import pycron
import operator
from croniter import croniter


def timestamp_utc_to_local(utc_timestamp: float) -> float:
    utc_time = datetime.datetime.fromtimestamp(utc_timestamp).replace(tzinfo=datetime.timezone.utc)
    return utc_time.astimezone().timestamp()


def datetime_utc_to_local(dt: datetime.datetime) -> datetime.datetime:
    utc_time = dt.replace(tzinfo=datetime.timezone.utc)
    return utc_time.astimezone()#.replace(tzinfo=None)


def print_cron_status():
    data = []
    for i, f in enumerate(pycron.scheduled_functions):
        last_run = datetime.datetime.fromtimestamp(f.last_run)
        next_run = croniter(f.cron_str, last_run).get_next(datetime.datetime)
        local = datetime_utc_to_local(next_run)
        now = datetime.datetime.now()
        relative = humanize.naturaltime(local.replace(tzinfo=None))
        string = f'{f.function.__module__:<25} ┃ {f.cron_str:>15} ┃ next run: ┃ {relative:>20} ┃ {local.replace(tzinfo=None)} (local UTC{local.tzinfo}) ┃ {next_run} (UTC)'
        data.append({
            'last_run': last_run,
            'next_run': next_run,
            'string': string,
        })
    data.sort(key=operator.itemgetter('next_run', 'last_run'))
    print('━' * 26 + '┳' + '━' * 17 + '┳' + '━' * 11 + '┳' + '━' * 22 + '┳' + '━' * 36 + '┳' + '━' * 26)
    for d in data:
        print(d['string'])
    print('━' * 26 + '┻' + '━' * 17 + '┻' + '━' * 11 + '┻' + '━' * 22 + '┻' + '━' * 36 + '┻' + '━' * 26)


def cron_status_after_call(func):
    @functools.wraps(func)
    async def wrapper(*args, **kwargs):
        result = await func(*args, **kwargs)
        print_cron_status()
        return result
    return wrapper


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
        task = runpy.run_path(p, init_globals={'pycron': pycron}, run_name=Path(p).stem)

    for i, f in enumerate(pycron.scheduled_functions):
        new_f = log_function_call(f.function) # wrap into logging function
        new_f = cron_status_after_call(new_f)
        pycron.scheduled_functions[i] = pycron.ScheduledFunc(
            function=new_f,
            cron_str=f.cron_str,
            last_run=f.last_run, # UTC
            # last_run=timestamp_utc_to_local(f.last_run), # local
        )
    print_cron_status()



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
