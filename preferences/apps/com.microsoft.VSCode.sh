#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Configure Visual Studio Code' 'step'

message 'Install extensions' 'substep'
bash "$(dirname $0)/../../apps/visual-studio-code/install-extensions.sh"
