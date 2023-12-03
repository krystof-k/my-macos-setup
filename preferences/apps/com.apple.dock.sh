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

<<<<<<< HEAD
=======
# TODO
# # + Speed up autohide
# defaults write com.apple.dock autohide-delay -float 0
# defaults write com.apple.dock autohide-time-modifier -float 0.5

# TODO works
# # + Clean dock apps
# defaults delete com.apple.dock persistent-apps

>>>>>>> 7df296b (TODO Configure dock)
# Windows & desktops

message 'Use scale effect when minimizing' 'substep'
defaults write com.apple.dock mineffect -string 'scale'

message "Don't rearrange desktops" 'substep'
defaults write com.apple.dock 'mru-spaces' -bool false

<<<<<<< HEAD
message 'Enable App Exposé gesture' 'substep'
=======
message "Enable App Exposé gesture" 'substep'
>>>>>>> 7df296b (TODO Configure dock)
defaults write com.apple.dock 'showAppExposeGestureEnabled' -bool true

# Launchpad

<<<<<<< HEAD
message 'Set launchpad layout to 4 × 5' 'substep'
defaults write com.apple.dock springboard-columns -int 4
defaults write com.apple.dock springboard-rows -int 5
=======
# TODO
# # + Set launchpad layout to 4 × 5
# defaults write com.apple.dock springboard-columns -int 4
# defaults write com.apple.dock springboard-rows -int 5
>>>>>>> 7df296b (TODO Configure dock)

message 'Restart dock' 'substep'
killall Dock
