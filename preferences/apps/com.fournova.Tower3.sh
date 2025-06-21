#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure Tower' 'step'

message 'Checkout branch after creating' 'substep'
defaults write com.fournova.Tower3 GTUserDefaultsDialogueOptionCheckoutCreatedBranch -bool true

message 'Show icons and text' 'substep'
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Display Mode" integer 1' ~/Library/Preferences/com.fournova.Tower3.plist

message 'Show create branch button' 'substep'
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers" array' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":0 string NSToolbarFlexibleSpaceItem' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":1 string GTToolbarItemGroupIdentifierDashboard' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":2 string NSToolbarSidebarTrackingSeparatorItemIdentifier' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":3 string GTToolbarItemIdentifierQuickOpen' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":4 string GTToolbarItemGroupIdentifierNavigation' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":5 string NSToolbarFlexibleSpaceItem' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":6 string GTToolbarItemIdentifierQuickActions' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":7 string GTToolbarItemIdentifierCreateBranch' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":8 string GTToolbarItemGroupIdentifierSync' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":9 string GTToolbarItemGroupIdentifierMerge' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":10 string GTToolbarItemGroupIdentifierStashes' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":11 string GTToolbarItemIdentifierGitFlow' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":12 string GTToolbarItemIdentifierRefresh' ~/Library/Preferences/com.fournova.Tower3.plist
/usr/libexec/PlistBuddy -c 'Add :"NSToolbar Configuration MainWindowToolbar.BigSur":"TB Item Identifiers":13 string GTToolbarItemIdentifierSearch' ~/Library/Preferences/com.fournova.Tower3.plist
defaults read com.fournova.Tower3 > /dev/null # reload plist file
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u # apply preferences

message 'Enable syntax coloring (also in diffs)' 'substep'
defaults write com.fournova.Tower3 GTUserDefaultsColorSyntax -bool true
defaults write com.fournova.Tower3 GTUserDefaultsColorSyntaxInDiffs -bool true

message 'Show invisible characters' 'substep'
defaults write com.fournova.Tower3 GTUserDefaultsShowInvisibleCharacters -bool true

message 'Set tab width to 2' 'substep'
defaults write com.fournova.Tower3 GTUserDefaultsSpacesPerTab -int 2
