from PIL import Image, ImageDraw
import os
img = Image.new('RGBA', (2000, 1000))

filename = 'README.png'
img.save(filename)

os.system('open ' + filename)
