#!/bin/sh

echo "DO_SETUP=$DO_SETUP"
echo "ENTRYPOINT_MODE=$ENTRYPOINT_MODE"

if [ "$DO_SETUP" = "1" ]; then
	entrypoints/setups/base.sh
fi

# You can check ENTRYPOINT_MODE to run different stuff
if [ "$ENTRYPOINT_MODE" = "shell" ]; then
	sh
else
  entrypoints/${ENV_NAME}.sh
fi
