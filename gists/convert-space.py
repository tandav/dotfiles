from glob import glob
import os
import sys

space = sys.argv[1]

notes = glob(f'{space}/*.html')
print(notes)

hashes = [
    os.path.splitext(os.path.basename(note))[0]
    for note in notes
]

print(hashes)

for hash in hashes:
    os.makedirs(f'{space}/notes/{hash}')
    os.rename(
        f'{space}/{hash}.html',
        f'{space}/notes/{hash}/{hash}.html'
    )

if os.path.exists(space + '/images'):
    images = os.listdir(space + '/images')
    print(images)

    for image in images:
        hash = os.path.splitext(image)[0]
        print(image, hash)
        os.rename(
            f'{space}/images/{image}',
            f'{space}/notes/{hash}/{image}',
        )
