import requests

host = 'http://localhost:5000'


# body = {
#     'script': 'open -a TextEdit',
#     'email'     : 'example@example.com'
# }

# r = requests.post(host + '/space/root/eval/open_finder', json=body)
# r = requests.patch(host + '/space/root/eval/open_finder', json=body)
r = requests.get(host + '/space/root/finder')
print(r.status_code, r.text)
# print(r.json())
