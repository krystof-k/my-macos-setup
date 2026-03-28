#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

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

message 'Restart dock' 'substep'
killall Dock 2>/dev/null || true
