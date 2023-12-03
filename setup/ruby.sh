#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../utilities/message.sh"

message 'Set up Ruby version manager' 'step'
message "Currently using Ruby (`ruby --version`) at \``which ruby`\`" 'substep' 'info'
message 'Add rbenv to ~/.zprofile' 'substep'
echo '# Ruby version manager' >> ~/.zprofile
echo 'eval "$(rbenv init -)"' >> ~/.zprofile
echo '' >> ~/.zprofile
message 'Reload .zprofile' 'substep'
source ~/.zprofile
rbenv install 3.2.2
rbenv global 3.2.2
message "Currently using Ruby (`ruby --version`) at \``which ruby`\`" 'substep' 'info'
