#!/bin/bash

set -e # exit on any error

# Download the ./utilities/message.sh file if not running inside a Git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  message=$(curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/krystof-k/my-macos-setup/main/utilities/message.sh)
  eval "$message"
else
  source ./utilities/message.sh
fi

message 'Prepare for setup'

message 'Have you enabled full disk access for terminal? [Y/n]' 'step' 'prompt'
read -n 1 -s -r REPLY
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  message 'Please enable it, restart terminal and rerun the setup script' 'substep' 'prompt'
  sleep 2
  open 'x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles'
  exit 1
fi

message 'Create a clean APFS snapshot' 'step'
tmutil localsnapshot

if [[ ! $@ =~ --skip-authentication ]]; then
  message 'Please sign into the App Store manually and press any key to continue' 'step' 'prompt'
  sleep 2
  open -a "App Store"
  read -n 1 -s -r

  message 'Add private key' 'step'
  message 'Enter absolute path to your private key' 'substep' 'prompt'
  read PRIVATE_KEY_PATH
  PRIVATE_KEY_FILENAME=`basename $PRIVATE_KEY_PATH`
  message 'Move private key to `~/.ssh`' 'substep'
  mkdir -p ~/.ssh
  mv $PRIVATE_KEY_PATH ~/.ssh/$PRIVATE_KEY_FILENAME
  chmod 600 ~/.ssh/$PRIVATE_KEY_FILENAME
  message 'Add it to SSH agent' 'substep'
  # -K option is deprecated in favor of --apple-use-keychain since macOS Monterey
  ssh-add --apple-use-keychain ~/.ssh/$PRIVATE_KEY_FILENAME
  message 'Add it to `~/.ssh/config`' 'substep'
  tee -a ~/.ssh/config << END > /dev/null
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/$PRIVATE_KEY_FILENAME
END
  message "Export public key to \`~/.ssh/${PRIVATE_KEY_FILENAME%.pem}.pub\`" 'substep'
  ssh-keygen -y -f ~/.ssh/$PRIVATE_KEY_FILENAME > ~/.ssh/${PRIVATE_KEY_FILENAME%.pem}.pub
else
  message 'Skipping authentication' 'info'
fi
