#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/message.sh"

# Create folder for the diff
message 'Insert app name:' 'prompt'
read NAME

# Retrieve bundle ID
BUNDLE_ID=$(osascript -e "id of app \"$NAME\"")
echo "$BUNDLE_ID"
