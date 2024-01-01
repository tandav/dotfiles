# import subprocess
# import shlex
# import pycron
import asyncio


# schedule = '* * * * * */1' # every 1 second
# schedule = '*/5 * * * *' # every 5 minutes
# # @pycron.cron("* * * * * */5") # every 5 seconds
# # @pycron.cron("* * * * * */10") # every 10 seconds
# @pycron.cron("*/20 * * * *")
@pycron.cron('*/5 * * * *') # every 5 minutes
# @pycron.cron("* * * * * */1") # every 1 second
# @pycron.cron('* * * * * */5') # every 5 seconds
async def main(timestamp):
    print('hello world')
    cmd = 'echo HHHAAHAHAHA'
    # await asyncio.create_subprocess_shell(cmd)
    # await asyncio.create_subprocess_shell(cmd)
