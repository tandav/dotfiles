# pip install osmium
# pip install shapely[vectorized]

import osmium
import shapely.wkb as wkblib
import pickle
import pprint

wkbfab = osmium.geom.WKBFactory()

class AmenityListHandler(osmium.SimpleHandler):
    nodes = []
    areas = []

    def node(self, n):
        if 'amenity' in n.tags and n.tags['amenity'] in ['college', 'university']:
            self.nodes.append((n.tags.get('name'), n.location.lon, n.location.lat))
            # raise Exception
            ln = len(self.nodes)
            if len(self.nodes) % 100 == 0:
                print(f'len(nodes) = {ln}')
                if ln % 1000 == 0:
                    with open(f'tmp/nodes-{ln}.pickle', 'wb') as f:
                        pickle.dump(self.areas, f)

    def area(self, a):
        if 'amenity' in a.tags and a.tags['amenity'] in ['college', 'university']:
            try:
                wkb = wkbfab.create_multipolygon(a)
                poly = wkblib.loads(wkb, hex=True)
                centroid = poly.representative_point()
        
                self.areas.append((a.tags.get('name'), centroid.x, centroid.y))
                la = len(self.areas)
                if la % 100 == 0:
                    print(f'len(areas) = {la}')
                    if la % 1000 == 0:
                        with open(f'tmp/areas-{la}.pickle', 'wb') as f:
                            pickle.dump(self.areas, f)
            except:
                print('error at area:', a)


h = AmenityListHandler()
h.apply_file('russia-latest.osm.pbf') # curl --verbose -O https://download.geofabrik.de/russia-latest.osm.pbf

colleges_universities = h.nodes + h.areas

with open('colleges_universities.py', 'w') as f:
    f.write('colleges_universities = ')
    pprint.pprint(colleges_universities, width=1000, stream=f)
