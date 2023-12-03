#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure Siri' 'step'

message 'Enable type to Siri' 'substep'
defaults write com.apple.Siri 'TypeToSiriEnabled' -bool true
