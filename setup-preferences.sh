





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



echo "Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400

# Enable AirDrop over Ethernet and on Unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true


# Not sure it works




# disable caps
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000000}]}'







# Others

# Show battery percentage in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string YES
