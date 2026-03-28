#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Display email address on login screen' 'step'
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText 'krystof@korb.cz'
