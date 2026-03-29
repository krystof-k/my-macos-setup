#!/usr/bin/env bash

set -euo pipefail
trap 'rm -f my-macos-setup.key safe.zip' EXIT

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/message.sh"

message 'Encrypt safe' 'step'

message 'Create safe.zip' 'substep'
zip -r safe.zip safe

if [ ! -f my-macos-setup.key ]; then
  # shellcheck disable=SC2016
  message 'Decrypt encrypted `my-macos-setup.key.enc` key' 'substep'
  openssl pkeyutl -decrypt -in my-macos-setup.key.enc -out my-macos-setup.key -inkey ~/.ssh/krystof-k.pem
fi

message 'Encrypt safe.zip' 'substep'
openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -in safe.zip -out safe.zip.enc -pass file:my-macos-setup.key
