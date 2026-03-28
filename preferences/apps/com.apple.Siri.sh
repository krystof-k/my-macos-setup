#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Configure Siri' 'step'

message 'Enable type to Siri' 'substep'
defaults write com.apple.Siri 'TypeToSiriEnabled' -bool true
