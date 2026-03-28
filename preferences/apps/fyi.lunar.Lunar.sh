#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Configure Lunar' 'step'

message 'Install CLI integration' 'substep'
message 'Manually install CLI integration in settings' 'substep' 'to-do'
