#!/bin/bash

# switch to root

sudo su - root

# update

yum update -y

# Python packages

pip3 install wheel
pip3 install gunicorn flask

# app

mkdir /callback_app
cd callback_app

cat > application.py <<EOF
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello from Python!'

if __name__ == "__main__":
      app.run(host='0.0.0.0', port=80)
EOF

cat > wsgi.py <<EOF
from application import app

if __name__ == "__main__":
    app.run(port=80)
EOF

# run

gunicorn --bind 0.0.0.0:80 wsgi:app
