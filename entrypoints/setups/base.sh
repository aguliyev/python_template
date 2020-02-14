#!/bin/sh

echo "Setup env ${ENV_NAME}..."

# You can check ENTRYPOINT_MODE to run different stuff
entrypoints/setups/${ENV_NAME}.sh

echo "Setup done"
