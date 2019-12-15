#!/usr/bin/env bash

# Disable startup chime
sudo nvram SystemAudioVolume=" "

# Show battery percentage in the menu bar
defaults write com.apple.menuextra.battery ShowPercent -string YES

# Increase window resize speed
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save and print panels by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Don't save to cloud by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Enable AirDrop over Ethernet and on Unsupported Macs
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Prolong standby delay to 5 hours – faster wake
sudo pmset -a standbydelay 18000

# Don't offer new disks for TimeMachine backup
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Display host info after clicking clock on login screen
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName



# Run all scripts in ./preferences
for script in ./preferences/*.sh; do
  bash "$script"
done
