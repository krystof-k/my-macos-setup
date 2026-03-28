#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"
# shellcheck disable=SC1091
source "$script_directory/../utilities/idempotent.sh"

message 'Setup Homebrew'

if command -v brew &>/dev/null; then
  message 'Homebrew already installed' 'info'
else
  message 'Install Homebrew' 'step'
  echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# shellcheck disable=SC2016
message 'Ensure Homebrew is in `~/.zprofile`' 'substep'
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "homebrew" 'eval "$(/opt/homebrew/bin/brew shellenv)"
HOMEBREW_CURL_RETRIES=10'

# shellcheck disable=SC2016
message 'Reload `~/.zprofile`' 'substep'
# shellcheck disable=SC1090
source ~/.zprofile
