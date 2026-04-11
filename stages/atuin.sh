#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/idempotent.sh"

message 'Set up Atuin'

if ! command -v atuin &>/dev/null; then
  message 'Atuin is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

message 'Ensure Atuin is in `~/.zprofile`' 'step'
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "atuin" 'eval "$(atuin init zsh)"'
