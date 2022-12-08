import itertools

first      = lambda obj: next(iter(obj))
take       = lambda obj, n: list(itertools.islice(obj        , n))
take_items = lambda obj, n: list(itertools.islice(obj.items(), n))

# https://more-itertools.readthedocs.io/en/stable/api.html
def take   (n, iterable): return list(itertools.islice(iterable, n))
def chunked(iterable, n): return iter(functools.partial(take, n, iter(iterable)), [])
