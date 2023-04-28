def arange(start: float, stop: float, step: float = 1.0) -> list[float]:
    """Like range but supports floats (like numpy.arange)"""
    start = decimal.Decimal(str(start))
    stop = decimal.Decimal(str(stop))
    step = decimal.Decimal(str(step))
    if step <= 0:
        raise ValueError('Step must be >= 0')
    out = []
    current = start
    while current < stop:
        out.append(float(current))
        current += step
    return out
