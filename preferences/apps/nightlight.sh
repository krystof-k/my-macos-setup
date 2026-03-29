#!/usr/bin/env bash

set -e # exit on any error

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../../utilities/message.sh"

if ! command -v nightlight &>/dev/null; then
  message 'nightlight is not installed, skipping' 'info'
  return 0 2>/dev/null || exit 0
fi

message 'Enable night shift using nightlight' 'step'

message 'Enable from sunset to sunrise' 'substep'
nightlight schedule start

message 'Set the temperature to the warmest' 'substep'
nightlight temp 100
