#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure OneNote' 'step'

message 'Disable spellcheck' 'substep'
defaults write ~/Library/Containers/com.microsoft.onenote.mac/Data/Library/Preferences/com.microsoft.onenote.mac.plist ONEnableSpelling -bool false

message 'Disable autocorrect' 'substep'
defaults write ~/Library/Containers/com.microsoft.onenote.mac/Data/Library/Preferences/com.microsoft.onenote.mac.plist ONEnableAutoCorrect -bool false

message 'Manually disable auto capitalization in OneNote settings' 'substep' 'to-do'
