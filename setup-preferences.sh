# Rename computer
sudo scutil --set ComputerName "Kryštof's MacBook Pro"
sudo scutil --set LocalHostName 'krystofs-macbook-pro'

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent YES

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Enable App Exposé gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Set recent items limit to 50
defaults write NSGlobalDomain NSRecentDocumentsLimit -int 50

# Empty the trash after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Display path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable autocorrect, autocapitalization, etc.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable startup chime
sudo nvram SystemAudioVolume=" "
