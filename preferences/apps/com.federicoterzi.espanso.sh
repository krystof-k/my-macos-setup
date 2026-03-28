#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Configure Espanso' 'step'

message 'Link the config folder to the Git repository' 'substep'
ln -sf ~/Git/krystof-k/my-macos-setup/apps/espanso ~/Library/Application\ Support/espanso
