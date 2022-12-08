def sets_info(table_a, table_b, col_a, col_b):
    '''
    print set informations about values in 2 columns
    usefull for various ids
    '''
    a = frozenset(spark.table(table_a).rdd.map(lambda x: getattr(x, col_a)).distinct().collect())
    b = frozenset(spark.table(table_b).rdd.map(lambda x: getattr(x, col_b)).distinct().collect())
    
    print('a = {}.{}'.format(table_a, col_a))
    print('b = {}.{}'.format(table_b, col_b))
    print('len a:', len(a    ))
    print('len b:', len(b    ))
    print('a | b:', len(a | b))
    print('a & b:', len(a & b))
    print('a ^ b:', len(a ^ b))
    a_b = len(a - b)
    b_a = len(b - a)
    print('a - b:', a_b)
    print('b - a:', b_a)
    
    if a_b == 0:
        print('a is subset of b')
    
    if b_a == 0:
        print('b is subset if a')
