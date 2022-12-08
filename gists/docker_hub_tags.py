import requests
import json

tags = []

image = 'jupyter/pyspark-notebook'
url = f'https://hub.docker.com/v2/repositories/{image}/tags'
r = requests.get(url, params={'page_size': 100, 'page': 1}).json()
while True:
    tags += r['results']
    url = r['next']
    if url is None:
        break
    print(url)
    r = requests.get(url).json()



def amd64_digest(tag: dict) -> str:
    return next(im for im in tag['images'] if im['architecture'] == 'amd64')['digest'].removeprefix('sha256:')

tag_digest = [(tag['name'], amd64_digest(tag)) for tag in tags if 'python-3' in tag['name']]

with open('tag_digest.json', 'w') as f:
    json.dump(tag_digest, f)


# example output:
# tag_digest = [
#   ('python-3.10.4', '70373b9ad296b451507849a3e4a42d04dae5e5e37a283f17200109752f2fa125'),
#   ('python-3.9.13', '586b2983c60ee4778237abba1bb1ea05109f97c70212b37d4d8cd96f7cc0075b'),
#   ('python-3.9.12', '91a2dc8f9d81dae420cf57ea94e18c7a7125c54beed7631fdbcf48d2f84d2aa9'),
#   ('python-3.9.10', 'b963a3707c99b5a000b3a287719a44a85df19cd06e7e3175ac49716fd332f636'),
#   ('python-3.9.7' , '6d8bae3cec913403a5233a118199f6d3196d36eca0bad81feea51fb3fddfa2ec'),
#   ('python-3.9.6' , '0967bd271dc9785b33de5c5333502f93f1b6646c3a3109950fb699de64f15a9e'),
#   ('python-3.9.5' , '22908e014eacdbb86d4cda87d4c215d0b2354d88f29a5fbc510d7c642da10851'),
#   ('python-3.9.4' , '359360c15c13f408c1a0aac57df0e288e4ced2c1eed303382ff29c241c5430a0'),
#   ('python-3.9.2' , '86a662f7510a6f79470851422f429659bdd55588ba7dd4dbc67cd34e5338e5aa'),
#   ('python-3.8.8' , 'f69846a54e7ad2a4f0ddf1dd8e3d48a8ea54fc69a327fed2b868d47109d1937b'),
# ]
