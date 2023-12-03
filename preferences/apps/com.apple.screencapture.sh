#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure screen capture' 'step'

message 'Set screen capture location to ~/Screenshots' 'substep'
mkdir -p ~/Screenshots
defaults write com.apple.screencapture 'location' -string '~/Screenshots'

message 'Disable shadow' 'substep'
defaults write com.apple.screencapture 'disable-shadow' -bool true
