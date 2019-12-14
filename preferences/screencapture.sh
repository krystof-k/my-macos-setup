#!/usr/bin/env bash

# Set default folder to ~/Screenshots
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

# Disable shadow
defaults write com.apple.screencapture disable-shadow -bool true
