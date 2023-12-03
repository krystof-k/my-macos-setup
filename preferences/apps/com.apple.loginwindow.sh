#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Display email address on login screen' 'step'
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText 'krystof@korb.cz'
