#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Shortcuts' 'step'

message 'Allow scripts' 'substep'
message 'Manually allow running scripts' 'substep' 'to-do'
