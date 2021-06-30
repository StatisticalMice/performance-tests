from flask import Flask
from flask import request
import sys
import numpy as np
ii64 = np.iinfo(np.int64)
import json

app = Flask(__name__)

@app.route("/")
def index():
    return f"Welcome to Flask! This site is served by {sys.version}"

@app.route("/random")
def rand():
    num = int(request.args.get('num', '1'))
    rands = np.random.randint(ii64.min, high=ii64.max, dtype=np.int64, size=num)
    return json.dumps(rands.tolist())

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=False)
