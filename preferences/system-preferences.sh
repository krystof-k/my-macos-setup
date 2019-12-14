# General

# Set dark mode automatically
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true

# Set default sidebar size to small
defaults write -g NSTableViewDefaultSizeMode -int 1

# Set recent items limit to 50
echo " Set recent items limit to 50 manually in Preferences / General."



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



# Mission Control

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false



# Siri

# Spotlight

# Language & Region

# Notifications

# Internet Accounts

# Users & Groups

# Accessibility

# Screen Time

# Extensions

# Security & Privacy

# Set ask for password deplay to 5 seconds
echo " Set ask for password delay to 5 seconds manually in Preferences / Security & Privacy."



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

# Printers & Scanners

# Keyboard

# Disable autocorrect, autocapitalization, etc.
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false



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



# Sharing

# Rename computer
sudo systemsetup -setcomputername "Kryštof's MacBook Pro"
sudo systemsetup -setlocalsubnetname "krystofs-macbook-pro"



# Time Machine

# Startup Disk
