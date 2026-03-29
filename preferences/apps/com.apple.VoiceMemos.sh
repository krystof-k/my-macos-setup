#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure voice memos' 'step'

message 'Use lossless quality' 'substep'
defaults write com.apple.VoiceMemos 'RCVoiceMemosAudioQualityKey' -int 1

message 'Keep deleted recordings for 30 days' 'substep'
defaults write com.apple.VoiceMemos 'RCVoiceMemosRecentlyDeletedWindowKey' -int 30
