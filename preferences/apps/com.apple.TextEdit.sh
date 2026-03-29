#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure TextEdit' 'step'

message 'Set plain text as default' 'substep'
defaults write com.apple.TextEdit 'RichText' -bool false

message 'Open untitled file instead of panel' 'substep'
defaults write com.apple.TextEdit 'NSShowAppCentricOpenPanelInsteadOfUntitledFile' -bool false
