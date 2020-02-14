#!/bin/sh

echo "DO_SETUP=$DO_SETUP"
echo "ENTRYPOINT_MODE=$ENTRYPOINT_MODE"

if [ "$DO_SETUP" = "1" ]; then
	entrypoints/setups/base.sh
fi

# You can check ENTRYPOINT_MODE to run different stuff
if [ "$ENTRYPOINT_MODE" = "shellrun" ]; then
	sh
else
  # You can run environment specific setup:
  [ -f entrypoints/${ENV_NAME}.sh ] && entrypoints/${ENV_NAME}.sh
  # otherwise, run default
  [ -f entrypoints/${ENV_NAME}.sh ] || entrypoints/default.sh
fi
