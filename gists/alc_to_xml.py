'''
also .als
'''

import gzip
from pathlib import Path


with gzip.open('808.alc', 'rt') as als:
    xml = als.read()


Path('808.xml').write_text(xml)

# import xml.etree.ElementTree as ET
# root = ET.fromstring(xml)
