#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"
# shellcheck disable=SC1091
source "$script_directory/../utilities/run.sh"

message 'Install apps'

if ! command -v brew &>/dev/null; then
  message 'Homebrew is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

run 'Install apps from Brewfile' brew bundle
