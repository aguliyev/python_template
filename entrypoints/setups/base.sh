#!/bin/sh

echo "Setup env ${ENV_NAME}..."

# You can check ENTRYPOINT_MODE to run different stuff

# You can run additionally environment specific setup:
[ -f entrypoints/setups/${ENV_NAME}.sh ] && entrypoints/setups/${ENV_NAME}.sh

echo "Setup done"
