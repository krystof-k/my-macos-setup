#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

if ! command -v git &>/dev/null; then
  message 'Git is not installed, skipping' 'info'
  return 0 2>/dev/null || exit 0
fi

message 'Configure Git' 'step'

message 'Set Git defaults' 'substep'
git config --global user.name 'Kryštof Korb'
git config --global user.email 'krystof@korb.cz'

message 'Add global .gitignore' 'substep'
cp "$script_directory/../../.gitignore.global" ~/.gitignore
git config --global core.excludesfile ~/.gitignore

message 'Use origin for branches without tracking upstream' 'substep'
git config --global push.autoSetupRemote true

message 'Use main as default branch' 'substep'
git config --global init.defaultBranch main

message 'Use nano as default editor' 'substep'
git config --global core.editor nano
