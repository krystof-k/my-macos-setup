#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"

message 'Set up Node version manager' 'step'
if command -v node >/dev/null 2>&1; then
  message "Currently using Node.js (`node --version`) at \``which node`\`" 'substep' 'info'
fi
message 'Add NVM to ~/.zprofile' 'substep'
mkdir -p ~/.nvm
# shellcheck disable=SC2016
{
  echo '# Node version manager'
  echo 'export NVM_DIR=~/.nvm'
  echo 'source $(brew --prefix nvm)/nvm.sh'
  echo 'source $(brew --prefix nvm)/etc/bash_completion.d/nvm'
  echo ''
} >> ~/.zprofile
message 'Reload .zprofile' 'substep'
source ~/.zprofile
message 'Install Node.js 22' 'substep'
nvm install 22
message "Currently using Node.js (`node --version`) at \``which node`\`" 'substep' 'info'

message 'Update npm' 'step'
npm install -g npm@latest

message 'Install Yarn' 'step'
npm install --global yarn
