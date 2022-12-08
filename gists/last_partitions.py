import subprocess
import pyspark.sql.functions as f

def last_partitions(table, n=3):
    _ = ['hive', '-e', 'show partitions {}'.format(table)]
    _ = subprocess.check_output(_)
    _ = _.decode()
    _ = _.splitlines()
    part_column, part_value = _[-n].split('=')
    return f.col(part_column) >= part_value
