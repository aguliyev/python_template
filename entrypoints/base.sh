#!/bin/sh

echo "DO_SETUP=$DO_SETUP"
if [ "$DO_SETUP" = "1" ]; then
	entrypoints/setups/base.sh
fi

entrypoints/${ENV_NAME}.sh
