#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/idempotent.sh"

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

message 'Set shell preferences' 'step'

# shellcheck disable=SC2016
message 'Set default terminal editor to `nano` in `~/.zshenv`' 'substep'
append_block_if_missing ~/.zshenv "default-editor" "export EDITOR=/opt/homebrew/bin/nano"

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

# message 'Switch to a nearest NTP server' 'substep'
# sudo systemsetup -setnetworktimeserver ntp.nic.cz

message 'Add ~/Git to Spotlight exclusions' 'substep'
if ! sudo /usr/libexec/PlistBuddy -c "Print :Exclusions" /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist 2>/dev/null | grep -q "$HOME/Git"; then
  sudo /usr/libexec/PlistBuddy -c "Add :Exclusions:0 string '$HOME/Git'" /System/Volumes/Data/.Spotlight-V100/VolumeConfiguration.plist
fi

message 'Enable firewall' 'substep'
sudo /usr/libexec/ApplicationFirewall/socketfilterfw \
  --setblockall off \
  --setallowsigned on \
  --setallowsignedapp on \
  --setstealthmode off \
  --setglobalstate on

message 'Turn off display after 3 minutes' 'substep'
sudo pmset -a displaysleep 3

message 'Sleep after 3 minutes on battery' 'substep'
sudo pmset -b sleep 3

message 'Sleep after 30 minutes on power' 'substep'
sudo pmset -c sleep 30

message 'Set computer name' 'step'
sudo scutil --set ComputerName "Kryštof's MacBook Pro"

message 'Set hostname' 'step'
sudo scutil --set LocalHostName krystofs-macbook-pro

message 'Manually set keyboard backlight limit to 30 seconds' 'substep' 'to-do'
message 'Manually disable Caps Lock for all keyboards' 'substep' 'to-do'
message 'Manually set ask for password delay to 5 seconds' 'substep' 'to-do'
message 'Manually turn on encryption' 'substep' 'to-do'
