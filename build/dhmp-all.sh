#!/bin/bash

script_path=$(cd "$(dirname "$0")" ; pwd -P)
base_path=$(dirname "$script_path")

echo ----Starting Doomsday pack----
source $script_path/dhmp-doomsday.sh
