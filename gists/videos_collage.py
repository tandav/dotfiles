import subprocess
import itertools
from pathlib import Path


VIDEO_FOLDER = 'videos'
AUDIO_FILE   = 'ballout_trim.mov'

_ = Path(VIDEO_FOLDER)
_ = _.iterdir()
_ = filter(lambda x: x.name != '.DS_Store', _)
_ = itertools.islice(_, 16)
_ = list(_)
videos = _
inds = range(len(videos))

div = len(videos) ** 0.5
side = int(div)
assert div - side == 0

cmd = (
    'ffmpeg',
    '-y',
    '-vsync', '2',
    '-hwaccel', 'videotoolbox',
)

THUMBNAIL_SIZE = 400

for v in videos:
    cmd += '-stream_loop', '-1', '-i', str(v)



# print(cmd)

filter_complex = ''

for i in inds:
    filter_complex += f'[{i}:v] setpts=PTS-STARTPTS, scale={THUMBNAIL_SIZE}:{THUMBNAIL_SIZE},setsar=1/1 [a{i}];'

xstack = ''.join(f'[a{i}]' for i in inds) + f'xstack=inputs={len(videos)}:layout='
xstack += '|'.join(
    f'{x * THUMBNAIL_SIZE}_{y * THUMBNAIL_SIZE}'
    for x, y in itertools.product(range(side), repeat=2)
)
xstack += '[out]'
filter_complex += xstack
cmd += '-filter_complex', filter_complex



cmd += (
    '-map', '[out]',
    '-c:v', 'h264_videotoolbox',
    '-framerate', '30',
    '-b:v', '10M',
    '-t', '60',
    'noaudio.mp4',
)

# print(cmd)

subprocess.run(cmd)

subprocess.run((
    'ffmpeg', '-y', '-i', 'noaudio.mp4', '-i', AUDIO_FILE,
    '-c:v', 'copy',
    '-map', '0:v',
    '-map', '1:a',
    '-shortest',
    'out.mp4',
))

subprocess.run(('open', 'out.mp4'))
