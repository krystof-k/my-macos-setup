#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure screen capture' 'step'

message 'Set screen capture location to ~/Screenshots' 'substep'
mkdir -p ~/Screenshots
# shellcheck disable=SC2088
defaults write com.apple.screencapture 'location' -string '~/Screenshots'

message 'Disable shadow' 'substep'
defaults write com.apple.screencapture 'disable-shadow' -bool true
