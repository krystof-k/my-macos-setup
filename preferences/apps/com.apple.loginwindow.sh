#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Display email address on login screen' 'step'
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText 'krystof@korb.cz'
