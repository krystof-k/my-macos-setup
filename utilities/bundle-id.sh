#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/message.sh"

# Create folder for the diff
message 'Insert app name:' 'prompt'
read -r NAME

# Retrieve bundle ID
BUNDLE_ID=$(osascript -e "id of app \"$NAME\"")
echo "$BUNDLE_ID"
