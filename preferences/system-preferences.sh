#!/usr/bin/env bash

# General

# Set dark mode automatically
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

# Set default sidebar size to small
defaults write -g NSTableViewDefaultSizeMode -int 1

# Set recent items limit to 50
echo " Set recent items limit to 50 manually in Preferences / General." | tee -a to-do.txt



# Desktop & Screen Saver

# Turn off screen saver
defaults -currentHost write com.apple.screensaver idleTime -int 0



# Dock

# Set dock size
defaults write com.apple.dock tilesize -int 48

# Use scale effect when minimizing
defaults write com.apple.dock mineffect -string scale

# Double click window header to minimize
defaults write -g AppleActionOnDoubleClick -string Minimize

# Autohide dock
defaults write com.apple.dock autohide -bool true

# + Lock dock size
defaults write com.apple.dock size-immutable -bool true

# + Clean dock apps
defaults delete com.apple.dock persistent-apps

# + Speed up autohide
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.5



# Mission Control

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false



# Siri

# Hide Siri from menu bar
defaults write com.apple.Siri StatusMenuVisible -bool false



# Spotlight



# Language & Region



# Notifications



# Internet Accounts



# Users & Groups

# Allow input selection
sudo defaults write /Library/Preferences/com.apple.loginwindow.plist showInputMenu -bool true



# Accessibility

# Download enhanced voice
echo " Download enhanced voice manually manually in Preferences / Accessibility / Speech." | tee -a to-do.txt

# Type to Siri
defaults write com.apple.Siri TypeToSiriEnabled -bool true



# Screen Time



# Extensions



# Security & Privacy

# Set ask for password deplay to 5 seconds
echo " Set ask for password delay to 5 seconds manually in Preferences / Security & Privacy / General." | tee -a to-do.txt

# Turn on encryption
echo " Don't forget to turn on encryption in Preferences / Security & Privacy / FileVault." | tee -a to-do.txt

# Turn on firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on



# Software Update

# Enable only automatic check & critical updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool false
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool false
sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool false
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true



# Network



# Bluetooth

# Display Bluetooth in the menu bar
/usr/libexec/PlistBuddy -c "Add :menuExtras: string '/System/Library/CoreServices/Menu Extras/Bluetooth.menu'" ~/Library/Preferences/com.apple.systemuiserver.plist
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true



# Sound

# Disable sound effects
echo " Disable UI sound effects 50 manually in Preferences / Sound." | tee -a to-do.txt

# Display sound control in the menu bar
/usr/libexec/PlistBuddy -c "Add :menuExtras: string '/System/Library/CoreServices/Menu Extras/Volume.menu'" ~/Library/Preferences/com.apple.systemuiserver.plist
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -bool true


# Printers & Scanners



# Keyboard

# Turn off keyboard backlight after 30 seconds
echo " Set keyboard backlight limit to 30 seconds manually in Preferences / Keyboard / Keyboard." | tee -a to-do.txt

# Disable autocorrect, autocapitalization, etc.
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Enable dictation
defaults write com.apple.HIToolbox AppleDictationAutoEnable -bool true



# Trackpad

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -g com.apple.mouse.tapBehavior -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -bool true

# Enable App Exposé gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true



# Mouse



# Displays

# Adjust resolution to more space
echo " Set resolution to more space manually in Preferences / Displays / Display." | tee -a to-do.txt



# Energy Saver

# Put display to sleep after 1 minutes
sudo pmset -b displaysleep 1
sudo pmset -c displaysleep 1

# Put computer to sleep after 2 minutes on battery and 30 minutes on power
sudo pmset -b sleep 2
sudo pmset -c sleep 30

# Turn off disk sleep
sudo pmset -a disksleep 0



# Date & Time

# Set nearest NTP server
sudo systemsetup -setnetworktimeserver ntp.nic.cz

# Show date in the menu bar
defaults write com.apple.menuextra.clock DateFormat -string "EEE d. M. H:mm"



# Sharing

# Rename computer
sudo systemsetup -setcomputername "Kryštof's MacBook Pro"
sudo systemsetup -setlocalsubnetname "krystofs-macbook-pro"



# Time Machine



# Startup Disk
