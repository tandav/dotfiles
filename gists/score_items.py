import random
import string
import collections
import operator
import tqdm
import matplotlib.pyplot as plt
import time
import concurrent.futures
from functools import reduce
from typing import Callable
import statistics
import pickle
import numpy as np

def char_sum(x: str):
    return sum(map(ord, x))


def char_sum2(x: str):
    ords = list(map(ord, x))
    s = sum(ords)
    return sum([o/s for o in ords])


def percent_less_than_mean(x: list):
    s = sum(x)
    n = sum(1 for _ in x)
    mean = s / n
    less = filter(lambda i: i <= mean, x)
    n_less = sum(1 for _ in less)
    
    return n_less / n

def score_items(
    s     : set        , 
    score : Callable   ,
    frac  : float = 0.9,
    n_iter: int   = 100,
):
    item_scores = dict.fromkeys(s, 0)
    item_scores = collections.Counter(item_scores)
    
    n_sample = int(frac * len(s))
    for i in tqdm.trange(n_iter):
        sample = random.sample(s, n_sample)
        _score = score(sample)
        item_score = _score / n_sample
        for item in sample:
            item_scores[item] += item_score
        
    return item_scores


def score_items_parallel(
    s     : set        , 
    score : Callable   ,
    frac  : float = 0.9,
    n_iter: int   = 100,
    n_jobs: int   =  16,
):
    n_iter_per_job = n_iter // n_jobs # approx!
    with concurrent.futures.ProcessPoolExecutor(max_workers=n_jobs) as pool:
        tasks = [
            pool.submit(score_items, s, score, frac, n_iter_per_job)
            for _ in range(n_jobs)
        ]
        results = [task.result() for task in tasks]
        C = reduce(operator.add, results)
    return C


if __name__ == '__main__':
    # c = score_items_parallel(string.ascii_lowercase, score=char_sum2, frac=0.99, n_iter=16 * 5_000_000)
    c = score_items_parallel(list(range(100)), score=percent_less_than_mean, frac=0.3, n_iter=16 * 5_000_000)
    # c = score_items_parallel(np.linspace(0, 10, 40).tolist(), score=percent_less_than_mean, frac=0.5, n_iter=16 * 500_000)
    # print(c.most_common(10))
    print(c.most_common())

    with open('c.pkl', 'wb') as fd: pickle.dump(c, fd)
