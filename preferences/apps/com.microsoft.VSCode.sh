#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/run.sh"

message 'Configure Visual Studio Code' 'step'

run 'Install VS Code extensions' bash "$script_directory/../../apps/visual-studio-code/install-extensions.sh"
