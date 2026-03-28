#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/../../utilities/message.sh"

message 'Enable night shift using nightlight' 'step'

message 'Enable from sunset to sunrise' 'substep'
nightlight schedule start

message 'Set the temperature to the warmest' 'substep'
nightlight temp 100
