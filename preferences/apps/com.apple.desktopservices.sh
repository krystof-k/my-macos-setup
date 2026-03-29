#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Avoid creating .DS_Store files on network and USB volumes' 'step'
defaults write com.apple.desktopservices 'DSDontWriteNetworkStores' -bool true
defaults write com.apple.desktopservices 'DSDontWriteUSBStores' -bool true
