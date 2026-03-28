#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"

message 'Set up Ruby version manager' 'step'
message "Currently using Ruby (`ruby --version`) at \``which ruby`\`" 'substep' 'info'
message 'Add rbenv to ~/.zprofile' 'substep'
# shellcheck disable=SC2016
{
  echo '# Ruby version manager'
  echo 'eval "$(rbenv init -)"'
  echo ''
} >> ~/.zprofile
message 'Reload .zprofile' 'substep'
# shellcheck disable=SC1090
source ~/.zprofile
rbenv install 3.4.4
rbenv global 3.4.4
message "Currently using Ruby (`ruby --version`) at \``which ruby`\`" 'substep' 'info'
