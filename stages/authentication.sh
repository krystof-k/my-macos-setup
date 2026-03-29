#!/usr/bin/env bash

set -euo pipefail

# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/message.sh"
# shellcheck disable=SC1091
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../utilities/idempotent.sh"

message 'Authentication'

message 'Sign into the App Store' 'step'
message 'Please sign in manually and press any key to continue' 'substep' 'prompt'
sleep 2
open -a "App Store"
read -n 1 -s -r

message 'Add private key' 'step'
if ls ~/.ssh/*.pem &>/dev/null; then
  # shellcheck disable=SC2016
  message 'Private key already exists in `~/.ssh`' 'substep' 'info'
else
  message 'Enter absolute path to your private key' 'substep' 'prompt'
  read -r -p "$(echo -e "${GRAY_DARK}│${RESET}    ")" PRIVATE_KEY_PATH
  PRIVATE_KEY_FILENAME=$(basename "$PRIVATE_KEY_PATH")
  # shellcheck disable=SC2016
  message 'Move private key to `~/.ssh`' 'substep'
  mkdir -p ~/.ssh
  cp "$PRIVATE_KEY_PATH" ~/.ssh/"$PRIVATE_KEY_FILENAME"
  chmod 600 ~/.ssh/"$PRIVATE_KEY_FILENAME"
  # shellcheck disable=SC2016
  message 'Add it to SSH agent' 'substep'
  message 'Enter your private key passphrase' 'substep' 'prompt'
  # -K option is deprecated in favor of --apple-use-keychain since macOS Monterey
  ssh-add --apple-use-keychain ~/.ssh/"$PRIVATE_KEY_FILENAME" 2>/dev/null
  # shellcheck disable=SC2016
  message 'Ensure SSH config is in `~/.ssh/config`' 'substep'
  append_block_if_missing ~/.ssh/config "ssh-host" "Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/${PRIVATE_KEY_FILENAME}"
  message "Export public key to \`~/.ssh/${PRIVATE_KEY_FILENAME%.pem}.pub\`" 'substep'
  ssh-keygen -y -f ~/.ssh/"$PRIVATE_KEY_FILENAME" > ~/.ssh/"${PRIVATE_KEY_FILENAME%.pem}".pub 2>/dev/null
fi

# shellcheck disable=SC2016
message 'Ensure GitHub is in `~/.ssh/known_hosts`' 'substep'
if ! grep -q 'github.com' ~/.ssh/known_hosts 2>/dev/null; then
  ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null
fi

message 'Add GitHub Packages token' 'step'
if grep -q 'GITHUB_PACKAGES_TOKEN' ~/.zshenv 2>/dev/null; then
  message 'GitHub Packages token already configured' 'substep' 'info'
  # shellcheck disable=SC1090
  source ~/.zshenv
else
  message 'Enter GitHub Packages token' 'substep' 'prompt'
  read -rs GITHUB_PACKAGES_TOKEN
  echo
  message 'Enter GitHub Packages token username' 'substep' 'prompt'
  read -r -p "$(echo -e "${GRAY_DARK}│${RESET}    ")" GITHUB_PACKAGES_TOKEN_USERNAME
  # shellcheck disable=SC2016
  message 'Ensure token is in `~/.zshenv`' 'substep'
  append_block_if_missing ~/.zshenv "github-packages" "export GITHUB_PACKAGES_TOKEN=${GITHUB_PACKAGES_TOKEN}
export GITHUB_PACKAGES_TOKEN_USERNAME=${GITHUB_PACKAGES_TOKEN_USERNAME}"
  # shellcheck disable=SC2016
  message 'Reload `~/.zshenv`' 'substep'
  # shellcheck disable=SC1090
  source ~/.zshenv
fi

# shellcheck disable=SC2016
message 'Ensure token is in `~/.npmrc`' 'substep'
# shellcheck disable=SC2016
append_block_if_missing ~/.npmrc "github-packages-npm" '//npm.pkg.github.com/:_authToken=${GITHUB_PACKAGES_TOKEN}'
