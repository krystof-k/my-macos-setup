#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../../utilities/message.sh"

message 'Configure Espanso' 'step'

message 'Link the config folder to the Git repository' 'substep'
rm -rf ~/Library/Application\ Support/espanso
ln -s ~/Git/krystof-k/my-macos-setup/apps/espanso ~/Library/Application\ Support/espanso
