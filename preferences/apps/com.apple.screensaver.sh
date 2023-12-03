#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Disable screen saver' 'step'
defaults -currentHost write com.apple.screensaver 'idleTime' -int 0
