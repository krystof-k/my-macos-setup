#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"

message 'Set up Claude Code'

message 'Configure Claude Code' 'step'

settings_file="$HOME/.claude/settings.json"
mkdir -p "$HOME/.claude"

if [[ -f "$settings_file" ]]; then
  tmp=$(mktemp)
  jq '.cleanupPeriodDays = 365' "$settings_file" > "$tmp" && mv "$tmp" "$settings_file"
else
  echo '{"cleanupPeriodDays": 365}' > "$settings_file"
fi

message 'Set cleanup period to 365 days' 'substep'
