#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Espanso' 'step'

message 'Link the config folder to the Git repository' 'substep'
config_dir="$HOME/Library/Application Support/espanso"
# `ln -sfn` cannot replace a real directory (created if espanso launched first)
if [[ -d "$config_dir" && ! -L "$config_dir" ]]; then
  mv "$config_dir" "$config_dir.backup-$(date +%Y%m%d%H%M%S)"
fi
ln -sfn ~/Git/krystof-k/my-macos-setup/apps/espanso "$config_dir"
