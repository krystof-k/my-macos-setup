#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

if [[ -d /Applications/Ghostty.app ]]; then
  message 'Configure Ghostty' 'step'

  config_dir="$HOME/Library/Application Support/com.mitchellh.ghostty"

  message 'Symlink Ghostty config' 'substep'
  mkdir -p "$config_dir"
  ln -sf ~/Git/krystof-k/my-macos-setup/apps/ghostty/config.ghostty "$config_dir/config.ghostty"

  message 'Set Ghostty as default terminal' 'substep' 'to-do'
fi
