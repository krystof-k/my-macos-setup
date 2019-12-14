#!/usr/bin/env bash

# Plaintext as default
defaults write com.apple.TextEdit RichText -bool false

# Disable smart*
defaults write com.apple.TextEdit CheckSpellingWhileTyping -bool false
defaults write com.apple.TextEdit CorrectSpellingAutomatically -bool false
defaults write com.apple.TextEdit SmartCopyPaste -bool false
defaults write com.apple.TextEdit SmartDashes -bool false
defaults write com.apple.TextEdit SmartQuotes -bool false
defaults write com.apple.TextEdit SmartSubstitutionsEnabledInRichTextOnly -bool false
