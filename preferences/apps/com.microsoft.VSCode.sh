#!/usr/bin/env bash

set -euo pipefail

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/run.sh"

message 'Configure Visual Studio Code' 'step'

message 'Symlink settings to the Git repository' 'substep'
mkdir -p ~/Library/Application\ Support/Code/User
ln -sf ~/Git/krystof-k/my-macos-setup/apps/visual-studio-code/settings.json ~/Library/Application\ Support/Code/User/settings.json

run 'Install VS Code extensions' bash "$script_directory/../../apps/visual-studio-code/install-extensions.sh"
