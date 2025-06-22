#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../utilities/message.sh"

message 'Set up Python version manager' 'step'
message "Currently using Python (`python3 --version`) at \``which python3`\`" 'substep' 'info'
message 'Add pyenv to ~/.zprofile' 'substep'
echo '# Python version manager' >> ~/.zprofile
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
echo 'eval "$(pyenv init -)"' >> ~/.zprofile
echo '' >> ~/.zprofile
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
