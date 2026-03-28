#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"
# shellcheck disable=SC1091
source "$script_directory/../utilities/idempotent.sh"
# shellcheck disable=SC1091
source "$script_directory/../utilities/run.sh"

ruby_version="${1:-3.4.9}"

message 'Set up Ruby'

if ! command -v rbenv &>/dev/null; then
  message 'rbenv is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

message 'Set up Ruby version manager' 'step'
if command -v ruby &>/dev/null; then
  message "Currently using Ruby $(ruby -e 'puts RUBY_VERSION') at \`$(which ruby)\`" 'substep' 'info'
fi

# shellcheck disable=SC2016
message 'Ensure rbenv is in `~/.zprofile`' 'substep'
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "rbenv" 'eval "$(rbenv init -)"'

# shellcheck disable=SC2016
message 'Reload `~/.zprofile`' 'substep'
# shellcheck disable=SC1090
source ~/.zprofile

if rbenv versions --bare | grep -q "$ruby_version"; then
  message "Ruby $ruby_version already installed" 'substep' 'info'
else
  run "Install Ruby $ruby_version" rbenv install -s "$ruby_version"
fi

message "Set Ruby $ruby_version as global default" 'substep'
rbenv global "$ruby_version"
message "Currently using Ruby $(ruby -e 'puts RUBY_VERSION') at \`$(which ruby)\`" 'substep' 'info'
