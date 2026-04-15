#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/idempotent.sh"

message 'Set up fzf'

if ! command -v fzf &>/dev/null; then
  message 'fzf is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

# shellcheck disable=SC2016
message 'Ensure fzf is in `~/.zshrc`' 'step'
# shellcheck disable=SC2016
append_block_if_missing ~/.zshrc "fzf" 'source <(fzf --zsh)'
