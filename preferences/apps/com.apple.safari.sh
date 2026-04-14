#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Safari' 'step'

message 'Disable autocorrect' 'substep'
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
