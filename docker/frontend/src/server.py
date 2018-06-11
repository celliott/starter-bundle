#!/usr/bin/env python

import os
import options
import requests
import json
from flask import Flask, render_template

app = Flask(__name__)
options = options.get()

@app.route("/", methods=['GET'])
def index():
    url = "http://{api_host}:{api_port}/".format(**options)
    data = requests.get(url, auth=(options['api_user'], options['api_pass'])).json()
    if data:
        data['secret'] = options['secret']
        return render_template('index', **data)
    else:
        return "<!> Coming Soon... </!>"

if __name__ == "__main__":
    app.run(host=options['app_host'], port=options['app_port'])
