#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Disable screen saver' 'step'
defaults -currentHost write com.apple.screensaver 'idleTime' -int 0
