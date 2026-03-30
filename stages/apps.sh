#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/run.sh"

message 'Install apps'

if ! command -v brew &>/dev/null; then
  message 'Homebrew is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

message 'Install Rosetta' 'step'
if arch -arch x86_64 /usr/bin/true 2>/dev/null; then
  message 'Already installed' 'substep' 'info'
else
  sudo softwareupdate --install-rosetta --agree-to-license >> .my-macos-setup/logs/rosetta.log 2>&1
fi

message 'Install apps from Brewfile' 'step'
brew bundle --file "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../Brewfile" >> .my-macos-setup/logs/brew-bundle.log 2>&1
