#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/idempotent.sh"

if ! command -v stripe &>/dev/null; then
  message 'Stripe CLI is not installed, skipping' 'info'
  # shellcheck disable=SC2317
  return 0 2>/dev/null || exit 0
fi

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
