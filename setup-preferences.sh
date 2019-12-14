# Rename computer
sudo systemsetup -setcomputername "Kryštof's MacBook Pro"
sudo systemsetup -setlocalsubnetname 'krystofs-macbook-pro'





# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable startup chime
sudo nvram SystemAudioVolume=" "


# Expand save and print panels by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Don't save to cloud by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false







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










# Others

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string YES

# disable caps
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000000}]}'
