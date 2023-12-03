#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure Visual Studio Code' 'step'

message 'Install extensions' 'substep'
bash "$(dirname $0)/../../apps/visual-studio-code/install-extensions.sh"
