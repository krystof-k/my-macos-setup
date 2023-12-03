#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Avoid creating .DS_Store files on network and USB volumes' 'step'
defaults write com.apple.desktopservices 'DSDontWriteNetworkStores' -bool true
defaults write com.apple.desktopservices 'DSDontWriteUSBStores' -bool true
