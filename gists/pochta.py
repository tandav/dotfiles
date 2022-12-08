import requests
import sys

# track_id = 'RU236134115HK'
# track_id = 'LZ592331954CN'
# track_id = sys.argv[1]

url = f'https://www.pochta.ru/tracking?p_p_id=trackingPortlet_WAR_portalportlet&p_p_lifecycle=2&p_p_state=normal&p_p_mode=view&p_p_resource_id=getList&p_p_cacheability=cacheLevelPage&p_p_col_id=column-1&p_p_col_pos=1&p_p_col_count=2&barcodeList={track_id}&postmanAllowed=true&_=1529492229987'

r = requests.get(url)

tracks = r.json()['list'][0]['trackingItem']['trackingHistoryItemList']

for track in tracks:
    print(track['date'], track['humanStatus'], track['description'])
