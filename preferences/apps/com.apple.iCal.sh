#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure calendar' 'step'

message 'Show week numbers' 'substep'
defaults write com.apple.iCal 'Show Week Numbers' -bool true

message 'Start day at 9:00' 'substep'
defaults write com.apple.iCal 'first minute of work hours' -int 540

message 'End day at 20:00' 'substep'
defaults write com.apple.iCal 'last minute of work hours' -int 1200

message 'Display 16 hours' 'substep'
defaults write com.apple.iCal 'number of hours displayed' -int 16

message 'Set default event duration to 30 minutes' 'substep'
defaults write com.apple.iCal 'Default duration in minutes for new event' -int 30

message 'Hide birthdays calendar' 'substep'
defaults write com.apple.iCal 'display birthdays calendar' -bool false

message 'Manually change default calendar to Google' 'substep' 'to-do'
message 'Manually set Google calendar refresh to 1 minute' 'substep' 'to-do'
