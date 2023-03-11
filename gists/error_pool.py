import concurrent.futures
import time


def error_sleep(t):
    time.sleep(t)
    raise RuntimeError


class ErrorPool:
    def __init__(self, max_workers=None):
        self.pool = concurrent.futures.ThreadPoolExecutor(max_workers=None)
        self.tasks = []

    def submit(self, f, *args, **kwargs):
        task = self.pool.submit(f, *args, **kwargs)
        self.tasks.append(task)

    def shutdown(self):
        for task in concurrent.futures.as_completed(self.tasks):
            # if task raises an exception inside,
            # it will be raised in main thread
            result = task.result()
        self.pool.shutdown(wait=True)

    def __enter__(self): return self
    def __exit__(self, exc_type, exc_val, exc_tb): self.shutdown()


with ErrorPool() as pool:
    pool.submit(time.sleep, 3)
    pool.submit(error_sleep, 2) # will raise error
    pool.submit(time.sleep, 5)
    pool.submit(time.sleep, 1)
