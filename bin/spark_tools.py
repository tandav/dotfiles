import functools
import pyspark.sql.functions as f
import pyspark
import operator


def column_like(column, rules):
    '''any of rule'''
    mask = f.lit(False)
    for rule in rules:
        mask |= f.col(column).like(rule)
    return mask


def union_dfs(dfs):
    return functools.reduce(
        pyspark.sql.DataFrame.union,
        dfs
    )


def intersect_dfs(dfs):
    return functools.reduce(
        pyspark.sql.DataFrame.intersect,
        dfs
    )



class Spark:
    def __init__(self, spark):
        self.spark = spark


# def df_to_list(df): return df.rdd.flatMap(lambda x: x).collect()
# def df_to_set (df): return set(df_to_list(df))


def df_to_set(df):
    return set(
        df
        .distinct()
        .rdd
        .flatMap(lambda x: x)
        .collect()
    )


# aw = DfWrapper(a)
# bw = DfWrapper(b)
# assert to_set(a) & to_set(b) == to_set((aw & bw).df)
# assert to_set(a) | to_set(b) == to_set((aw | bw).df)
# assert to_set(a) - to_set(b) == to_set((aw - bw).df)
