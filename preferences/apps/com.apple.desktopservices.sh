#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Avoid creating .DS_Store files on network and USB volumes' 'step'
defaults write com.apple.desktopservices 'DSDontWriteNetworkStores' -bool true
defaults write com.apple.desktopservices 'DSDontWriteUSBStores' -bool true
