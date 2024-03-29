#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure Finder' 'step'

message 'Set grouping by date added as default' 'substep'
defaults write com.apple.finder 'FXPreferredGroupBy' -string 'Date Added'

message 'Calculate folder sizes' 'substep'
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:calculateAllSizes bool true' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ListViewSettings:calculateAllSizes bool true' ~/Library/Preferences/com.apple.finder.plist

message 'Set column view style as default' 'substep'
defaults write com.apple.finder 'FXPreferredViewStyle' -string 'clmv'

message 'Sort folders first' 'substep'
defaults write com.apple.finder '_FXSortFoldersFirst' -bool true

message 'Show path bar' 'substep'
defaults write com.apple.finder 'ShowPathbar' -bool true

message 'Set current folder as the default search scope' 'substep'
defaults write com.apple.finder 'FXDefaultSearchScope' -string 'SCcf'

message 'Hide warning when changing extension' 'substep'
defaults write com.apple.finder 'FXEnableExtensionChangeWarning' -bool false

message 'Empty bin items after 30 days' 'substep'
defaults write com.apple.finder 'FXRemoveOldTrashItems' -bool true

message 'Show quit menu option' 'substep'
defaults write com.apple.finder 'QuitMenuItem' -bool true

message 'Show home folder for new windows' 'substep'
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string '~/'

message 'Manually display Library folder in home folder preferences' 'substep' 'to-do'
message 'Manually show home folder in sidebar' 'substep' 'to-do'
message 'Manually set recent items limit to 50' 'substep' 'to-do'

# Desktop

message 'Hide icons on desktop' 'substep'
defaults write com.apple.finder 'CreateDesktop' -bool false

message 'Hide external disks on desktop' 'substep'
defaults write com.apple.finder 'ShowExternalHardDrivesOnDesktop' -bool false

message 'Hide removable media on desktop' 'substep'
defaults write com.apple.finder 'ShowRemovableMediaOnDesktop' -bool false

message 'Restart Finder' 'substep'
killall Finder
