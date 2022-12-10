#!/usr/bin/env bash

set -euo pipefail
script_dir=$(dirname "${BASH_SOURCE[0]}") 

#######################################
# Switch to the provided wallpaper
# 
# Args:
# key: string =>  The wallpaper key, used to lookup the asset
# mode: string => The mode to use, one of center|fill|max|scale|tile
#######################################
function switchWallpaper() {
    local key=$1
    local mode=$2

    echo "Switching to $key.png with mode $mode"

    nix-shell -p feh --run "feh --bg-$mode $script_dir/../assets/$key.png"
}
