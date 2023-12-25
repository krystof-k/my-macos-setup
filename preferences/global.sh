#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../utilities/message.sh"

message 'Set input preferences' 'step'

message 'Disable autocorrect' 'substep'
defaults write -g 'NSAutomaticSpellingCorrectionEnabled' -bool false

message 'Disable automatic capitalization' 'substep'
defaults write -g 'NSAutomaticCapitalizationEnabled' -bool false

message 'Disable smart quotes' 'substep'
defaults write -g 'NSAutomaticQuoteSubstitutionEnabled' -bool false

message 'Disable smart dashes' 'substep'
defaults write -g 'NSAutomaticDashSubstitutionEnabled' -bool false

message 'Enable double spacebar period' 'substep'
defaults write -g 'NSAutomaticPeriodSubstitutionEnabled' -bool true

message 'Set other preferences' 'step'

message 'Switch to dark mode automatically' 'substep'
if defaults read -g 'AppleInterfaceStyle' > /dev/null 2>&1; then
  defaults remove -g 'AppleInterfaceStyle'
fi
defaults write -g 'AppleInterfaceStyleSwitchesAutomatically' -bool true

message 'Double click window header to minimize' 'substep'
defaults write -g 'AppleActionOnDoubleClick' -string 'Minimize'

message 'Show file extensions' 'substep'
defaults write -g 'AppleShowAllExtensions' -bool true

message 'Expand save and print panels' 'substep'
defaults write -g 'NSNavPanelExpandedStateForSaveMode' -bool true
defaults write -g 'PMPrintingExpandedStateForPrint' -bool true

message 'Switch to a nearest NTP server' 'substep'
sudo systemsetup -setnetworktimeserver ntp.nic.cz

message 'Add ~/Git to Spotlight exclusions' 'substep'
sudo /usr/libexec/PlistBuddy -c "Add :Exclusions:0 string '/Users/krystof-k/Git'" /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist
sudo launchctl stop com.apple.metadata.mds
sudo launchctl start com.apple.metadata.mds

message 'Enable firewall' 'substep'
sudo /usr/libexec/ApplicationFirewall/socketfilterfw \
  --setblockall off \
  --setallowsigned on \
  --setallowsignedapp on \
  --setloggingmode on \
  --setstealthmode off \
  --setglobalstate on

message 'Turn off display after 3 minutes' 'substep'
sudo pmset -a displaysleep 3

message 'Sleep after 3 minutes on battery' 'substep'
sudo pmset -b sleep 3

message 'Sleep after 30 minutes on power' 'substep'
sudo pmset -c sleep 30

message 'Set computer name'
sudo scutil --set ComputerName "Kryštof’s MacBook Pro"

message 'Set hostname'
sudo scutil --set LocalHostName krystofs-macbook-pro

message 'Manually set keyboard backlight limit to 30 seconds' 'substep' 'to-do'
message 'Manually disable Caps Lock for all keyboards' 'substep' 'to-do'
message 'Manually set ask for password delay to 5 seconds' 'substep' 'to-do'
message 'Manually turn on encryption' 'substep' 'to-do'
