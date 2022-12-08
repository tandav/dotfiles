import pandas as pd


def try_downcast(s):
    '''
    s: pd.Series
    return new series
    
    keep in mind that using float16, int8, int16 etc (small dtypes) is unsafe when computing .mean(), .sum()
    (they can easily be overflown and as a result you'll get nan/inf/broken values)
    '''
    
    def float_is_useless(x):
        '''
        if all floats have .0 at the end
        then this is useless (can be converted to int)
        '''
        return (x.dropna() % 1 == 0).all()
    
    min_, max_ = s.min(), s.max()
    
    def _downcast(x, num_type):
        if num_type is int:
            info_func = np.iinfo
            subtypes  = (np.int8, np.int16, np.int32, np.int64)
        
        if num_type is float:
            info_func = np.finfo
            # subtypes  = (np.float16, np.float32, np.float64)
            subtypes  = (np.float32, np.float64) # float32 is unsafe, see docstring
            
            
        for dt in subtypes:
            if dt == x.dtype:
                print('cant downcast, just return input series')
                return x
            if info_func(dt).min <= min_ and max_ <= info_func(dt).max:
                print('successfull downcast: {} -> {}'.format(x.dtype, dt))
                return x.astype(dt)
    
    def float_castable_to_int(x):
        '''
        see also: pandas >= 0.24: there is nullable integer data type
        https://pandas.pydata.org/pandas-docs/stable/user_guide/integer_na.html
        (aint using it in this function)
        '''
        return float_is_useless(x) and s.notna().all()
    
    if pd.api.types.is_float_dtype(s) and not float_castable_to_int(s):
        return _downcast(s, float)
    return _downcast(s, int)


def downcast_df(df):
    df = df.copy()
    for c, s in df.iteritems():
        if not pd.api.types.is_numeric_dtype(s):
            continue
        df[c] = try_downcast(s)
    return df
