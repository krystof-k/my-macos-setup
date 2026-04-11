#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure control center' 'step'

message 'Always show sound control' 'substep'
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC Sound' -bool true
defaults -currentHost write com.apple.controlcenter 'Sound' -int 18

message 'Always show Bluetooth' 'substep'
defaults write com.apple.controlcenter 'NSStatusItem VisibleCC Bluetooth' -bool true
defaults -currentHost write com.apple.controlcenter 'Bluetooth' -int 2
