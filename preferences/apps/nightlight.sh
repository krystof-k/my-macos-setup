#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Enable night shift using nightlight' 'step'

message 'Enable from sunset to sunrise' 'substep'
nightlight schedule start

message 'Set the temperature to the warmest' 'substep'
nightlight temp 100
