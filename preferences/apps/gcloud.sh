#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/idempotent.sh"

if ! command -v gcloud &>/dev/null; then
  message 'Google Cloud CLI is not installed, skipping' 'info'
  # shellcheck disable=SC2317
  return 0 2>/dev/null || exit 0
fi

message 'Set up Google Cloud CLI' 'step'

# shellcheck disable=SC2016
message 'Ensure gcloud components PATH is in `~/.zprofile`' 'substep'
# shellcheck disable=SC2016
append_block_if_missing ~/.zprofile "gcloud" 'export PATH="$HOMEBREW_PREFIX/share/google-cloud-sdk/bin:$PATH"'
