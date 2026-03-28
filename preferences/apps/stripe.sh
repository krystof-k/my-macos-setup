#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/idempotent.sh"

message 'Set up autocompletion for Stripe CLI' 'step'

message 'Create ~/.stripe/stripe-completion.zsh' 'substep'
stripe completion
mkdir -p ~/.stripe
mv stripe-completion.zsh ~/.stripe

# shellcheck disable=SC2016
message 'Ensure Stripe is in `~/.zprofile`' 'substep'
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "stripe" 'fpath=(~/.stripe $fpath)
autoload -Uz compinit && compinit -i'
