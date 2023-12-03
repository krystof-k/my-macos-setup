#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure voice memos' 'step'

message 'Use lossless quality' 'substep'
defaults write com.apple.VoiceMemos 'RCVoiceMemosAudioQualityKey' -int 1

message 'Keep deleted recordings for 30 days' 'substep'
defaults write com.apple.VoiceMemos 'RCVoiceMemosRecentlyDeletedWindowKey' -int 30
