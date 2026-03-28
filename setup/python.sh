#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"

message 'Set up Python version manager' 'step'
message "Currently using Python (`python3 --version`) at \``which python3`\`" 'substep' 'info'
message 'Add pyenv to ~/.zprofile' 'substep'
# shellcheck disable=SC2016
{
  echo '# Python version manager'
  echo 'export PYENV_ROOT="$HOME/.pyenv"'
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
  echo 'eval "$(pyenv init -)"'
  echo ''
} >> ~/.zprofile
message 'Reload .zprofile' 'substep'
source ~/.zprofile
message 'Install Python 3.13' 'substep'
pyenv install 3.13
pyenv global 3.13
message "Currently using Python (`python3 --version`) at \``which python3`\`" 'substep' 'info'

message 'Upgrade pip3' 'step'
message "Currently using pip (`pip3 --version`) at \``which pip3`\`" 'substep' 'info'
pip3 install --upgrade pip
message "Currently using pip (`pip3 --version`) at \``which pip3`\`" 'substep' 'info'

message 'Install Python packages' 'step'
pip3 install -r "$(dirname $0)/../apps/python/requirements.txt"
