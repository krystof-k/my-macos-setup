#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

if [[ -d /Applications/Ghostty.app ]]; then
  message 'Configure Ghostty' 'step'

  config_dir="$HOME/Library/Application Support/com.mitchellh.ghostty"

  message 'Symlink Ghostty config' 'substep'
  mkdir -p "$(dirname "$config_dir")"
  ln -sfn ~/Git/krystof-k/my-macos-setup/apps/ghostty "$config_dir"

  message 'Set Ghostty as default terminal' 'substep' 'to-do'
fi
