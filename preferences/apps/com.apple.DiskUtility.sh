#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure disk utility' 'step'

message 'Show all devices' 'substep'
defaults write com.apple.DiskUtility 'SidebarShowAllDevices' -bool true

message 'Show APFS snapshots' 'substep'
defaults write com.apple.DiskUtility 'WorkspaceShowAPFSSnapshots' -bool true
