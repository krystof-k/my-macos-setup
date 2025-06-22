#!/bin/bash

set -e # exit on any error

source "$(dirname $0)/../utilities/message.sh"

message 'Open Docker, wait for the daemon to start and press any key to continue' 'step' 'prompt'
sleep 2
open -a Docker
read -n 1 -s -r

message 'Login to GitHub Container registry' 'substep'
echo $GITHUB_PACKAGES_TOKEN | docker login ghcr.io -u $GITHUB_PACKAGES_TOKEN_USERNAME --password-stdin
