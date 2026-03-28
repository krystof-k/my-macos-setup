#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Configure disk utility' 'step'

message 'Show all devices' 'substep'
defaults write com.apple.DiskUtility 'SidebarShowAllDevices' -bool true

message 'Show APFS snapshots' 'substep'
defaults write com.apple.DiskUtility 'WorkspaceShowAPFSSnapshots' -bool true
