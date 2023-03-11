import subprocess
import concurrent.futures

def db_tables(db):
    tables = (
        subprocess
        .check_output(['hive', '--database', db, '--silent', '-e', 'show tables'])
        .decode()
        .splitlines()
        [1:] # first row is 'tab_name'
    )

    with concurrent.futures.ThreadPoolExecutor() as pool:
        info = pool.map(lambda t: (t, spark.table(db + '.' + t).columns), tables)

    return dict(info)
