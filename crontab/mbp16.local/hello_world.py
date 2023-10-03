# import datetime
# import subprocess
# # import util
# import shlex
# import pycron


# schedule = '* * * * * */1' # every 1 second
# schedule = '*/5 * * * *' # every 5 minutes
# # @pycron.cron("* * * * * */5") # every 5 seconds
# # @pycron.cron("* * * * * */10") # every 10 seconds
# @pycron.cron("*/20 * * * *")
@pycron.cron('*/5 * * * *') # every 5 minutes
# @pycron.cron("* * * * * */1") # every 1 second
async def main(timestamp):
    print('hello world')
