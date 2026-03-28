#!/bin/bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Set up autocompletion for Stripe CLI' 'step'

message 'Create ~/.stripe/stripe-completion.zsh' 'substep'
stripe completion
mkdir -p ~/.stripe
mv stripe-completion.zsh ~/.stripe

message 'Add it to PATH' 'substep'
echo '# Stripe CLI autocompletion' >> ~/.zprofile
echo 'fpath=(~/.stripe $fpath)"' >> ~/.zprofile
echo 'autoload -Uz compinit && compinit -i' >> ~/.zprofile
echo '' >> ~/.zprofile
