#!/bin/sh

gunicorn --reload --log-level warning --log-file - --worker-class eventlet --workers 3 --timeout 300 --bind 0.0.0.0:5000 app.controller:app
