#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

message 'Configure Espanso' 'step'

message 'Link the config folder to the Git repository' 'substep'
ln -sfn ~/Git/krystof-k/my-macos-setup/apps/espanso ~/Library/Application\ Support/espanso
