#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

while IFS= read -r line || [[ -n "$line" ]]; do
  if [[ $line == \#* ]]; then
    continue
  fi
  
  code --install-extension "$line"
done < "$(dirname $0)/extensions.txt"
