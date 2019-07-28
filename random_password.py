import string
import secrets
import sys


if len(sys.argv) == 2:
    length = int(sys.argv[1])
else:
    length = 32

alphabet = string.ascii_letters + string.digits

password = ''.join(
    secrets.choice(alphabet) 
    for _ in range(length)
)

print(password)
