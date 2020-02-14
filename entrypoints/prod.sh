#!/bin/sh

# You can check ENTRYPOINT_MODE to run different stuff

echo "Running in prod"
gunicorn --reload --log-level info --log-file - --worker-class eventlet --workers 3 --timeout 300 --bind 0.0.0.0:5000 app.controller:app
