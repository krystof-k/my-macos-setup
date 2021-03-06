#!/usr/bin/env bash

# Preferences

# Don't show removable media on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Show home folder as default when opening new window
defaults write com.apple.finder NewWindowTarget -string PfHm
defaults write com.apple.finder NewWindowTargetPath -string '~/.'

# Display home folder in sidebar
echo " Manually show home folder in sidebar." | tee -a to-do.txt

# Display extensions
defaults write -g AppleShowAllExtensions -bool true

# Don't warn when changing extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Empty the trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Set current folder as a default search scope
defaults write com.apple.finder FXDefaultSearchScope -string SCcf



# View

# Set column layout as default
defaults write com.apple.finder FXPreferredViewStyle -string clmv

# Display path bar
defaults write com.apple.finder ShowPathbar -bool true

# Set grouping by date added as default
defaults write com.apple.finder FXPreferredGroupBy -string 'Date Added'

# Display folder sizes
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ListViewSettings:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:ExtendedListViewSettingsV2:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:ListViewSettings:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist

# Display home folder in sidebar
echo " Manually display Library folder in home folder preferences." | tee -a to-do.txt


# Other

# Show Quit Finder menu option
defaults write com.apple.finder QuitMenuItem -bool true

# Hide icons on desktop
defaults write com.apple.finder CreateDesktop -bool false
