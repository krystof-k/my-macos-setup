#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Siri' 'step'

message 'Enable type to Siri' 'substep'
defaults write com.apple.Siri 'TypeToSiriEnabled' -bool true
