#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/run.sh"

message 'Set up Codex'

if ! command -v codex &>/dev/null; then
  message 'Codex is not installed' 'error'
  # shellcheck disable=SC2317
  return 1 2>/dev/null || exit 1
fi

message 'Install Codex plugin for Claude Code' 'step'
run 'Add plugin marketplace' claude plugin marketplace add openai/codex-plugin-cc
run 'Install plugin' claude plugin install codex@openai-codex
