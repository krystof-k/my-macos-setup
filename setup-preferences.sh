# Rename computer
sudo systemsetup -setcomputername "Kryštof's MacBook Pro"
sudo systemsetup -setlocalsubnetname 'krystofs-macbook-pro'

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string YES

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -g com.apple.mouse.tapBehavior -int 1

# Enable App Exposé gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Set Windows-like keyboard shortcut for switching app windows
/usr/libexec/PlistBuddy -c "Delete :AppleSymbolicHotKeys:27 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27 dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27:enabled bool 1" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27:value dict" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27:value:type string standard" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27:value:parameters array" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27:value:parameters:0 integer 65535" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27:value:parameters:1 integer 48" ~/Library/Preferences/com.apple.symbolichotkeys.plist
/usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:27:value:parameters:2 integer 524288" ~/Library/Preferences/com.apple.symbolichotkeys.plist

# Empty the trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Display path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show Quit Finder menu option
defaults write com.apple.finder QuitMenuItem -bool true

# Display extensions
defaults write -g AppleShowAllExtensions -bool true

# Disable autocorrect, autocapitalization, etc.
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable startup chime
sudo nvram SystemAudioVolume=" "

# Set dock size
defaults write com.apple.dock tilesize -int 48

# Lock dock size
defaults write com.apple.dock size-immutable -bool true

# Autohide dock
defaults write com.apple.dock autohide -bool true

# Expand save and print panels by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Don't save to cloud by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Set current folder as a default search scope
defaults write com.apple.finder FXDefaultSearchScope -string SCcf

# Set default sidebar size to small
defaults write -g NSTableViewDefaultSizeMode -int 1


systemsetup -setnetworktimeserver ntp.nic.cz


mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

defaults write com.apple.screencapture disable-shadow -bool true

# Put display to sleep after 2 minutes
sudo pmset displaysleep 2
systemsetup -setdisplaysleep 2

# Put computer to sleep after 5 minutes
sudo pmset sleep 5
systemsetup -setcomputersleep 5

sudo pmset -b displaysleep 30
sudo pmset -c displaysleep 30
sudo pmset -b sleep 30
sudo pmset -c sleep 30

sudo pmset -a disksleep 0


echo "Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

# Enable AirDrop over Ethernet and on Unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true


# Not sure it works


# Display folder sizes
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ListViewSettings:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:ExtendedListViewSettingsV2:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:ListViewSettings:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist
#/usr/libexec/PlistBuddy -c 'Set :FK_StandardViewSettings:ExtendedListViewSettingsV2:calculateAllSizes true' ~/Library/Preferences/com.apple.finder.plist


# Set recent items limit to 50
defaults write NSGlobalDomain NSRecentDocumentsLimit -int 50
defaults write NSGlobalDomain NSNavRecentPlacesLimit -int 50
