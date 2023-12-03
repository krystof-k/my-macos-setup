#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure disk utility' 'step'

message 'Show all devices' 'substep'
defaults write com.apple.DiskUtility 'SidebarShowAllDevices' -bool true

message 'Show APFS snapshots' 'substep'
defaults write com.apple.DiskUtility 'WorkspaceShowAPFSSnapshots' -bool true
