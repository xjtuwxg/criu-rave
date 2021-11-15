#!/bin/bash
LIBRAVE_PATH=./rave/build/lib/

if [ $# != 1 ]; then
    echo "Use ./restore.sh <dir>"
    exit 1
fi

sudo LD_LIBRARY_PATH=./rave/build/lib/ ./criu/criu restore -j -D $1
