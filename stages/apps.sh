#!/usr/bin/env bash

set -e # exit on any error

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

sudo -v
# Keep sudo alive during long-running brew bundle
while true; do sudo -n true; sleep 50; done 2>/dev/null &
_sudo_keepalive_pid=$!
trap 'kill $_sudo_keepalive_pid 2>/dev/null' EXIT

run 'Install apps from Brewfile' brew bundle --file "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../Brewfile"
