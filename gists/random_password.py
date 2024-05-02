#!/usr/bin/env python3
'''
random password
base58 is used to remove easily mistakable characters: 0, O, I, l
- [Understanding and avoiding visually ambiguous characters in IDs | Hacker News](https://news.ycombinator.com/item?id=40127124)
'''

import string
import secrets
import sys

length = int(sys.argv[1]) if len(sys.argv) > 1 else 32
alphabet = ''.join(set(string.ascii_letters + string.digits) - set('O0Il'))
password = ''.join(secrets.choice(alphabet) for _ in range(length))
print(password)
