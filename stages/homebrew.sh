#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/idempotent.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/run.sh"

message 'Setup Homebrew'

# shellcheck disable=SC1090
[[ -f ~/.zprofile ]] && source ~/.zprofile

if command -v brew &>/dev/null; then
  message 'Homebrew already installed' 'info'
else
  message 'Authenticate for installation' 'step' 'prompt'
  sudo -v
  run 'Install Homebrew' env NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# shellcheck disable=SC2016
message 'Ensure Homebrew is in `~/.zprofile`' 'substep'
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "homebrew" 'eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_CURL_RETRIES=10'

# shellcheck disable=SC2016
message 'Reload `~/.zprofile`' 'substep'
# shellcheck disable=SC1090
source ~/.zprofile
