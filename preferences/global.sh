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
# TODO defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g 'PMPrintingExpandedStateForPrint' -bool true
# TODO defaults write -g PMPrintingExpandedStateForPrint2 -bool true

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
  --setstealthmode off \
  --setglobalstate on

message 'Manually set ask for password delay to 5 seconds' 'substep' 'to-do'
message 'Manually turn on encryption' 'substep' 'to-do'

message 'Turn off display after 1 minute' 'substep'
sudo pmset -a displaysleep 1

message 'Sleep after 2 minutes on battery' 'substep'
sudo pmset -b sleep 2

message 'Sleep after 30 minutes on power' 'substep'
sudo pmset -c sleep 30


message 'Manually set keyboard backlight limit to 30 seconds' 'substep' 'to-do'
message 'Manually disable Caps Lock for all keyboards' 'substep' 'to-do'

# TODO
# ↓ ↓ ↓ ↓ ↓ 




# manually downloads column view & group by date added

# manually set auto backlight and 10s timeout





# # Increase window resize speed
# defaults write NSGlobalDomain NSWindowResizeTime -float 0.01


# # Don't offer new disks for TimeMachine backup
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


# # Display host info after clicking clock on login screen
# sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo IPAddress



# defaults write -g com.apple.swipescrolldirection -bool true




# scutil --set ComputerName "Kryštof's MacBook Pro"
# scutil --set LocalHostName krystofs-macbook-pro
# scutil --set HostName krystofs-macbook-pro
# dscacheutil -flushcache

# # Rename computer
# sudo systemsetup -setcomputername "Kryštof's MacBook Pro"
# sudo systemsetup -setlocalsubnetname "krystofs-macbook-pro"



# # completeion
# tee -a ~/.zshrc << END > /dev/null
# if type brew &>/dev/null
# then
#   FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

#   autoload -Uz compinit
#   compinit
# fi
# END


# cat ~/Library/Application\ Support/Code/User/settings.json 


# # https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html

# aws configure --profile xyxy set aws_access_key_id `tail -1 ~/Downloads/krystof.korb_accessKeys.csv | cut -d ',' -f1`
# aws configure --profile xyxy set aws_secret_access_key `tail -1 ~/Downloads/krystof.korb_accessKeys.csv | cut -d ',' -f2`
# aws configure --profile xyxy set region eu-central-1
# aws configure --profile xyxy set output yaml
# # export AWS_PROFILE=xyxy

# python3 -m pip install --upgrade setuptools
# python3 -m pip install --upgrade pip





