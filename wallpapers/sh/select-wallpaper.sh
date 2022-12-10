#!/usr/bin/env bash

set -euo pipefail
script_dir=$(dirname "${BASH_SOURCE[0]}") 

source "$script_dir/lib.sh"
source $1
