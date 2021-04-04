#!/bin/bash
set -e

# Source files 
source "/opt/ros/foxy/setup.bash"
#source "/root/dev_ws/install/local_setup.bash"

exec "$@"
