#!/usr/bin/env bash

set -euo pipefail

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"

message 'Configure all apps preferences'

for script in "$script_directory/../preferences/apps/"*; do
  if [[ -x "$script" ]]; then
    "$script"
  fi
done
