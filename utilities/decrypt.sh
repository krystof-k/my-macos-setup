#!/usr/bin/env bash

set -e # exit on any error

script_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$script_directory/message.sh"

message 'Decrypt safe' 'step'

if [ ! -f my-macos-setup.key ]; then
  # shellcheck disable=SC2016
  message 'Decrypt encrypted `my-macos-setup.key.enc` key' 'substep'
  openssl pkeyutl -decrypt -in my-macos-setup.key.enc -out my-macos-setup.key -inkey ~/.ssh/krystof-k.pem
fi

message 'Decrypt safe.zip.enc' 'substep'
openssl enc -d -aes-256-cbc -salt -pbkdf2 -iter 100000 -in safe.zip.enc -out safe.zip -pass file:my-macos-setup.key

message 'Unzip safe.zip' 'substep'
unzip -o safe.zip
