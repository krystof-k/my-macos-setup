#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure TextEdit' 'step'

TEXTEDIT_DOMAIN="$HOME/Library/Containers/com.apple.TextEdit/Data/Library/Preferences/com.apple.TextEdit"

message 'Set plain text as default' 'substep'
defaults write "$TEXTEDIT_DOMAIN" 'RichText' -bool false

message 'Open untitled file instead of panel' 'substep'
defaults write "$TEXTEDIT_DOMAIN" 'NSShowAppCentricOpenPanelInsteadOfUntitledFile' -bool false
