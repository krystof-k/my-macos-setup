#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Lunar' 'step'

message 'Install CLI integration' 'substep'
message 'Manually install CLI integration in settings' 'substep' 'to-do'
