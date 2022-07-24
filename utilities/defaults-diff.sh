#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/message.sh"

# Create folder for the diff
message 'Insert diff name:' 'prompt'
read NAME
mkdir -p "diffs/$NAME"

# Read and save existing values
defaults read > "diffs/$NAME/old.plist"
defaults -currentHost read > "diffs/$NAME/host-old.plist"

message 'Change settings and press any key to continue' 'prompt'
read -n 1 -s -r

# Read and save new values
defaults read > "diffs/$NAME/new.plist"
defaults -currentHost read > "diffs/$NAME/host-new.plist"

# Show diff
message 'Here is your diff:' 'info'

diff "diffs/$NAME/old.plist" "diffs/$NAME/new.plist"
message 'snd here with the `-currentHost` option:' 'info'
diff "diffs/$NAME/host-old.plist" "diffs/$NAME/host-new.plist"
