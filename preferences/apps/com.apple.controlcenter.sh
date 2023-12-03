#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure control center' 'step'

message 'Always show sound control' 'substep'
defaults write com.apple.controlcenter 'NSStatusItem Visible Sound' -bool true
defaults -currentHost write com.apple.controlcenter 'Sound' -int 18

message 'Always show Bluetooth' 'substep'
defaults write com.apple.controlcenter 'NSStatusItem Visible Bluetooth' -bool true
defaults -currentHost write com.apple.controlcenter 'Bluetooth' -int 2
