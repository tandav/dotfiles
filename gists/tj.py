import re
import requests
import datetime
import sys

def ago(e):
    # e: pass timedelta between timestamps in 1579812524 format
    e *= 1000 # convert to 1579812524000 format
    t = round(e / 1000)
    n = round(t /   60)
    r = round(n /   60)
    o = round(r /   24)
    i = round(o /   30)
    a = round(i /   12)
    if   e <  0: return              'just now'
    elif t < 10: return              'just now'
    elif t < 45: return str(t) + ' seconds ago'
    elif t < 90: return          'a minute ago'
    elif n < 45: return str(n) + ' minutes ago'
    elif n < 90: return           'an hour ago'
    elif r < 24: return str(r) +   ' hours ago'
    elif r < 36: return             'a day ago'
    elif o < 30: return str(o) +    ' days ago'
    elif o < 45: return           'a month ago'
    elif i < 12: return str(i) +  ' months ago'
    elif i < 18: return            'a year ago'
    else:        return str(a) +   ' years ago'


class color:
    BLACK     = lambda s: '\033[30m' + str(s) + '\033[0m'
    RED       = lambda s: '\033[31m' + str(s) + '\033[0m'
    GREEN     = lambda s: '\033[32m' + str(s) + '\033[0m'
    YELLOW    = lambda s: '\033[33m' + str(s) + '\033[0m'
    BLUE      = lambda s: '\033[34m' + str(s) + '\033[0m'
    MAGENTA   = lambda s: '\033[35m' + str(s) + '\033[0m'
    CYAN      = lambda s: '\033[36m' + str(s) + '\033[0m'
    WHITE     = lambda s: '\033[37m' + str(s) + '\033[0m'
    UNDERLINE = lambda s: '\033[4m'  + str(s) + '\033[0m'


now = datetime.datetime.now()


site = 'vc'
if len(sys.argv) == 2:
    site = sys.argv[1] # dtf, vc

x = requests.get(f'https://api.{site}.ru/v1.9/timeline/mainpage').json()['result']
x = sorted(x, key=lambda post: post['commentsCount'], reverse=True)

for post in x:
    if post['url'].startswith('https://tjournal.ru/animals'):
        continue
    # print('-' * 80)
    # print(color.GREEN(f"{post['commentsCount']:>3} {post['title']}"), '\n', '    ' + post['url'], sep='')

    try:
        url = re.match(r'https://tjournal.ru/[a-z]+/[0-9]+', post['url']).group()
    except:
        url = 'ERROR' + post['url']

    if post['title']:
        dt = (now - datetime.datetime.fromtimestamp(post['date'])).total_seconds()
        time_ago = ago(dt)
        print(f"{post['commentsCount']:>3} {color.GREEN(post['title'])} {time_ago}", '    ' + url, sep='')

#html = requests.get('https://tjournal.ru/new').text
#pattern = re.compile('(?<=<h2 class="content-header__title l-island-a">).*?(?=</h2>)', re.DOTALL)
#for title in re.findall(pattern, html):
#    print(title.strip())
