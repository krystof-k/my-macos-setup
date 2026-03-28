#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../utilities/message.sh"
# shellcheck disable=SC1091
source "$script_directory/../utilities/idempotent.sh"
# shellcheck disable=SC1091
source "$script_directory/../utilities/run.sh"

python_version="${1:-3.13.5}"

message 'Set up Python'

if ! command -v pyenv &>/dev/null; then
  message 'pyenv is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

message 'Set up Python version manager' 'step'
if command -v python3 &>/dev/null; then
  message "Currently using Python $(python3 --version | awk '{print $2}') at \`$(which python3)\`" 'substep' 'info'
fi

# shellcheck disable=SC2016
message 'Ensure pyenv is in `~/.zprofile`' 'substep'
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "pyenv" 'export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"'

# shellcheck disable=SC2016
message 'Reload `~/.zprofile`' 'substep'
# shellcheck disable=SC1090
source ~/.zprofile

if pyenv versions --bare | grep -q "$python_version"; then
  message "Python $python_version already installed" 'substep' 'info'
else
  run "Install Python $python_version" pyenv install -s "$python_version"
fi

message "Set Python $python_version as global default" 'substep'
pyenv global "$python_version"
message "Currently using Python $(python3 --version | awk '{print $2}') at \`$(which python3)\`" 'substep' 'info'

run 'Upgrade pip' pip3 install --upgrade pip
run 'Install Python packages' pip3 install -r "$script_directory/../apps/python/requirements.txt"
