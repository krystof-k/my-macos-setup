#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/idempotent.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/run.sh"

node_version="${1:-24.14.1}"

message 'Set up Node.js'

if ! [[ -s "${NVM_DIR:-$HOME/.nvm}/nvm.sh" ]] && ! command -v nvm &>/dev/null; then
  message 'nvm is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

message 'Set up Node version manager' 'step'
if command -v node &>/dev/null; then
  message "Currently using Node.js $(node --version) at \`$(which node)\`" 'substep' 'info'
fi

# shellcheck disable=SC2016
message 'Ensure NVM is in `~/.zprofile`' 'substep'
mkdir -p ~/.nvm
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "nvm" 'export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
source $(brew --prefix nvm)/etc/bash_completion.d/nvm'

# shellcheck disable=SC2016
message 'Reload `~/.zprofile`' 'substep'
# shellcheck disable=SC1090
source ~/.zprofile

if nvm version "$node_version" &>/dev/null; then
  message "Node.js $node_version already installed" 'substep' 'info'
else
  run "Install Node.js $node_version" bash -c "source \${NVM_DIR:-\$HOME/.nvm}/nvm.sh && nvm install $node_version"
fi
nvm use "$node_version" &>/dev/null
nvm alias default "$node_version" &>/dev/null
message "Currently using Node.js $(node --version) at \`$(which node)\`" 'substep' 'info'

run 'Update npm' npm install -g npm@latest
run 'Install Yarn' npm install --global yarn
