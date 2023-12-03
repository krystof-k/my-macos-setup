#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure dock' 'step'

# Dock

message 'Set dock size' 'substep'
defaults write com.apple.dock tilesize -int 48

message 'Lock dock size' 'substep'
defaults write com.apple.dock 'size-immutable' -bool true

message 'Autohide dock' 'substep'
defaults write com.apple.dock 'autohide' -bool true

# Windows & desktops

message 'Use scale effect when minimizing' 'substep'
defaults write com.apple.dock mineffect -string 'scale'

message "Don't rearrange desktops" 'substep'
defaults write com.apple.dock 'mru-spaces' -bool false

message 'Enable App Exposé gesture' 'substep'
defaults write com.apple.dock 'showAppExposeGestureEnabled' -bool true

# Launchpad

message 'Set launchpad layout to 4 × 5' 'substep'
defaults write com.apple.dock springboard-columns -int 4
defaults write com.apple.dock springboard-rows -int 5

message 'Restart dock' 'substep'
killall Dock
