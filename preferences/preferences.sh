



# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write -g com.apple.mouse.tapBehavior -bool true
defaults write -g -currentHost com.apple.mouse.tapBehavior -bool true


# Set dark mode automatically
defaults write -g AppleInterfaceStyleSwitchesAutomatically -bool true


# Set default sidebar size to small
defaults write -g NSTableViewDefaultSizeMode -bool true


# Enable App Exposé gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true


# Use scale effect when minimizing
defaults write com.apple.dock mineffect -string scale


# Autohide dock
defaults write com.apple.dock autohide -bool true


# Double click window header to minimize
defaults write -g AppleActionOnDoubleClick -string Minimize



# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false


# Clean dock apps
defaults delete com.apple.dock persistent-apps


# Set dock size
defaults write com.apple.dock tilesize -int 48

# Lock dock size
defaults write com.apple.dock size-immutable -bool true

# Display extensions
defaults write -g AppleShowAllExtensions -bool true



