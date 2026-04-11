#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/helpers.sh"

message 'Sensitive data'

PHASE_DIR="${1:-}"
if [[ -z "$PHASE_DIR" ]]; then
  message 'Backup directory is not set' 'substep' 'prompt'
  exit 1
fi
mkdir -p "$PHASE_DIR"
FAIL_LOG="${FAIL_LOG:-$PHASE_DIR/failures.log}"

message 'SSH' 'step'
try_copy "$HOME/.ssh" dot-ssh

message 'GPG' 'step'
try_copy "$HOME/.gnupg" dot-gnupg

message 'AWS' 'step'
try_copy "$HOME/.aws/config" aws/config.txt
try_copy "$HOME/.aws/credentials" aws/credentials.txt

message 'Other credentials' 'step'
try_copy "$HOME/.netrc" dot-netrc.txt
try_copy "$HOME/.docker/config.json" docker/config.json
