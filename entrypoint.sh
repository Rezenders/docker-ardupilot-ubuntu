#!/bin/bash

set -e

source "/home/docker/ardupilot/Tools/completion/completion.bash"
. ~/.profile

exec "$@"
