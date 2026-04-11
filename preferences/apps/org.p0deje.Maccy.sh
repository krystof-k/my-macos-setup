#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

if [[ -d /Applications/Maccy.app ]]; then
  message 'Configure Maccy' 'step'

  message 'Set history size to 500' 'substep'
  defaults write org.p0deje.Maccy historySize -int 500

  message 'Enable launch at login' 'substep' 'to-do'

  message 'Grant Accessibility permission on first launch' 'substep' 'to-do'
fi
