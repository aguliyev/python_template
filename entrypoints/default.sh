#!/bin/sh

# You can check ENTRYPOINT_MODE to run different stuff

echo "Running in dev"
flask run --host=0.0.0.0
