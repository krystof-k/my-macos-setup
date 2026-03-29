#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Coca' 'step'

message 'Activate at launch' 'substep'
defaults write com.angomarcello.Coca launchActivate -bool true

message 'Hide window at launch' 'substep'
defaults write com.angomarcello.Coca showWindow -bool false

message 'Left-click activate' 'substep'
defaults write com.angomarcello.Coca behavior -bool true

message 'Allow display sleep' 'substep'
defaults write com.angomarcello.Coca allowsDisplay -bool true
