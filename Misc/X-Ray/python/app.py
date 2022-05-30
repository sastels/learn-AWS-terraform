# flask_web/app.py

from flask import Flask

from aws_xray_sdk.core import xray_recorder
from aws_xray_sdk.core import patch_all

xray_recorder.configure(service='My app')
plugins = ('ECSPlugin')
xray_recorder.configure(plugins=plugins)
patch_all()


app = Flask(__name__)

@app.route('/')
@xray_recorder.capture('## hello')
def hello_world():
    return f'Welcome to {site_name()}'



@xray_recorder.capture('## site_name')
def site_name():
    return "sja"