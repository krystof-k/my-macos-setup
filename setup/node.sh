#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../utilities/message.sh"

message 'Set up Node version manager' 'step'
if command -v node >/dev/null 2>&1; then
  message "Currently using Node.js (`node --version`) at \``which node`\`" 'substep' 'info'
fi
message 'Add NVM to ~/.zprofile' 'substep'
mkdir -p ~/.nvm
echo '# Node version manager' >> ~/.zprofile
echo 'export NVM_DIR=~/.nvm' >> ~/.zprofile
echo 'source $(brew --prefix nvm)/nvm.sh' >> ~/.zprofile
echo 'source $(brew --prefix nvm)/etc/bash_completion.d/nvm' >> ~/.zprofile
echo '' >> ~/.zprofile
message 'Reload .zprofile' 'substep'
source ~/.zprofile
message 'Install Node.js 22' 'substep'
nvm install 22
message "Currently using Node.js (`node --version`) at \``which node`\`" 'substep' 'info'

message 'Update npm' 'step'
npm install -g npm@latest

message 'Install Yarn' 'step'
npm install --global yarn
