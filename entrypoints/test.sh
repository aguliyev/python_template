#!/bin/sh

echo "DO_SETUP=$DO_SETUP"
if [ "$DO_SETUP" = "1" ]; then
	echo "Setup..."

	echo "Setup done"
fi

pytest tests
