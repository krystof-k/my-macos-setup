#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

while IFS= read -r line || [[ -n "$line" ]]; do
  if [[ $line == \#* ]]; then
    continue
  fi
  
  code --install-extension "$line"
done < "$script_directory/extensions.txt"
