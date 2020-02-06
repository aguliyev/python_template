#!/bin/sh

echo "DO_SETUP=$DO_SETUP"
echo "ENTRYPOINT_MODE=$ENTRYPOINT_MODE"
if [ "$DO_SETUP" = "1" ]; then
	entrypoints/setups/base.sh
fi

entrypoints/${ENV_NAME}.sh
