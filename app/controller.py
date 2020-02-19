import os
from flask import Flask, escape, request

app = Flask(__name__)
app.config['SECRET_KEY'] = os.getenv('SECRET_KEY')

@app.route("/")
def index():
    app.logger.info('/ request: ' + str(request.args))
    return f"Hello, ENV_NAME: {str(os.environ.get('ENV_NAME'))} , request: {escape(request.args)} "
