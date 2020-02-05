#!/bin/sh

echo "DO_SETUP=$DO_SETUP"
if [ "$DO_SETUP" = "1" ]; then
	echo "Setup..."

	echo "Setup done"
fi

gunicorn --reload --log-level debug --log-file - --worker-class eventlet --workers 1 --timeout 300 --bind 0.0.0.0:5000 app.controller:app
