'''
send email using your gmail
'''

from pathlib import Path
import random
import textwrap
import sys




import smtplib, ssl
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

FROM     = 'alx1dr@gmail.com' # your gmail account
TO       = FROM
PASSWORD = 'twzj nxti aovi hzil' # https://myaccount.google.com/apppasswords


message = MIMEMultipart()
message['From'] = FROM
message['To'] = TO
message['Subject'] = 'Email from MacBook'
body = 'This is an email with attachment sent from Python'


if len(sys.argv) == 2:
    text = sys.argv[1]
    message.attach(MIMEText(text, 'plain'))
else:
    text = '''\
    Hi,
    How are you?
    Real Python has many great tutorials:
    www.realpython.com
    '''

    _ = Path('/usr/share/dict/words')
    _ = _.read_text()
    _ = _.splitlines()
    _ = random.sample(_, 100)
    _ = ' '.join(_)
    noise = textwrap.fill(_)
    print(noise)

    html = f'''\
    Hello, guys!
    this is your code

    <pre>
    with smtplib.SMTP(host="smtp.gmail.com", port=587) as server:
        server.starttls(context=ssl.create_default_context())
        server.login(FROM, PASSWORD)
        server.sendmail(FROM, TO, message.as_string())


    additional random text:
    {noise}
    </pre>
    '''

    # message.attach(MIMEText(text, 'plain'))
    message.attach(MIMEText(html, 'html'))

with smtplib.SMTP(host='smtp.gmail.com', port=587) as server:
    server.starttls(context=ssl.create_default_context())
    server.login(FROM, PASSWORD)
    server.sendmail(FROM, TO, message.as_string())
