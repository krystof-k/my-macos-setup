#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

if [[ -d /Applications/Ghostty.app ]]; then
  message 'Configure Ghostty' 'step'

  message 'Set Ghostty as default terminal' 'substep' 'to-do'
fi
