#!/usr/bin/env bash

set -euo pipefail
script_dir=$(dirname "${BASH_SOURCE[0]}") 

source "$script_dir/lib.sh"

paper=$(find "$script_dir/../" -name "*.wp" | shuf -n1)

source $paper
