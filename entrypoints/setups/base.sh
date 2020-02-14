#!/bin/sh

echo "Setup env ${ENV_NAME}..."

# You can check ENTRYPOINT_MODE to run different stuff

# You can run environment specific setup:
entrypoints/setups/${ENV_NAME}.sh

echo "Setup done"
