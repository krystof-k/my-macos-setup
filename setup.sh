#!/bin/bash

set -e # exit on any error

# Download the ./utilities/message.sh file if not running inside a Git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  message=$(curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/krystof-k/my-macos-setup/main/utilities/message.sh)
  eval "$message"
else
  source ./utilities/message.sh
fi

message 'Prepare for setup'

message 'Have you enabled full disk access for terminal? [Y/n]' 'step' 'prompt'
read -n 1 -s -r REPLY
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  message 'Please enable it, restart terminal and rerun the setup script' 'substep' 'prompt'
  sleep 2
  open 'x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles'
  exit 1
fi

message 'Create a clean APFS snapshot' 'step'
tmutil localsnapshot
