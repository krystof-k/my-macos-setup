#!/usr/bin/env bash

set -euo pipefail

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

if [[ -d /Applications/Ghostty.app ]]; then
  message 'Configure Ghostty' 'step'

  config_dir="$HOME/Library/Application Support/com.mitchellh.ghostty"

  message 'Copy Ghostty config' 'substep'
  mkdir -p "$config_dir"
  cp "$script_directory/../../apps/ghostty/config.ghostty" "$config_dir/config.ghostty"

  message 'Set Ghostty as default terminal' 'substep' 'to-do'
fi
