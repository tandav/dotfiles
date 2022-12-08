def make_slices(n, block_size):
    '''
    >>> make_slices(100, 30)
    [slice(0, 30, None),
     slice(30, 60, None),
     slice(60, 90, None),
     slice(90, 100, None)]
    '''
    slices = []
    offset = 0
    while offset < n:
        real_block_size = min(block_size, n - offset)
        s = slice(offset, offset + real_block_size)
        slices.append(s)
        offset += real_block_size
    return slices
