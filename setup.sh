#!/bin/bash

set -e # exit on any error

if [ ! -f ./utilities/message.sh ]; then
  message=$(curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/krystof-k/my-macos-setup/main/utilities/message.sh)
  eval "$message"
else
  source ./utilities/message.sh
fi

setup_header

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

if [ ! -f /etc/pam.d/sudo_local ]; then
  message 'Enable Touch ID for sudo' 'step'
  sed -e 's/^#auth/auth/' /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local > /dev/null
fi

if [[ ! $* =~ --skip-authentication ]]; then
  message 'Please sign into the App Store manually and press any key to continue' 'step' 'prompt'
  sleep 2
  open -a "App Store"
  read -n 1 -s -r

  message 'Add private key' 'step'
  message 'Enter absolute path to your private key' 'substep' 'prompt'
  read -r PRIVATE_KEY_PATH
  PRIVATE_KEY_FILENAME=$(basename "$PRIVATE_KEY_PATH")
  # shellcheck disable=SC2016
  message 'Move private key to `~/.ssh`' 'substep'
  mkdir -p ~/.ssh
  cp "$PRIVATE_KEY_PATH" ~/.ssh/"$PRIVATE_KEY_FILENAME"
  chmod 600 ~/.ssh/"$PRIVATE_KEY_FILENAME"
  # shellcheck disable=SC2016
  message 'Add it to SSH agent' 'substep'
  # -K option is deprecated in favor of --apple-use-keychain since macOS Monterey
  ssh-add --apple-use-keychain ~/.ssh/"$PRIVATE_KEY_FILENAME"
  # shellcheck disable=SC2016
  message 'Add it to `~/.ssh/config`' 'substep'
  tee -a ~/.ssh/config << END > /dev/null
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/${PRIVATE_KEY_FILENAME}
END
  message "Export public key to \`~/.ssh/${PRIVATE_KEY_FILENAME%.pem}.pub\`" 'substep'
  ssh-keygen -y -f ~/.ssh/"$PRIVATE_KEY_FILENAME" > ~/.ssh/"${PRIVATE_KEY_FILENAME%.pem}".pub

  message 'Add GitHub Packages token' 'step'
  message 'Enter GitHub Packages token' 'substep' 'prompt'
  read -r GITHUB_PACKAGES_TOKEN
  message 'Enter GitHub Packages token username' 'substep' 'prompt'
  read -r GITHUB_PACKAGES_TOKEN_USERNAME
  # shellcheck disable=SC2016
  message 'Add token to `~/.zshenv`' 'substep'
  tee -a ~/.zshenv << END
# GitHub Packages read-only token
export GITHUB_PACKAGES_TOKEN=${GITHUB_PACKAGES_TOKEN}
export GITHUB_PACKAGES_TOKEN_USERNAME=${GITHUB_PACKAGES_TOKEN_USERNAME}
END
  message 'Reload .zshenv' 'substep'
  # shellcheck disable=SC1090
  source ~/.zshenv
  message 'Add token to ~/.npmrc' 'substep'
  # shellcheck disable=SC2016
  echo '//npm.pkg.github.com/:_authToken=${GITHUB_PACKAGES_TOKEN}' > ~/.npmrc
else
  message 'Skipping authentication' 'info'
fi

message 'Clone repository' 'step'
repository_directory="$HOME/Git/krystof-k/my-macos-setup"
if [[ -d "$repository_directory" ]]; then
  message 'Repository already cloned' 'substep' 'info'
else
  # shellcheck disable=SC2016
  message 'Clone repository to `~/Git/krystof-k/my-macos-setup`' 'substep'
  mkdir -p ~/Git/krystof-k
  git clone https://github.com/krystof-k/my-macos-setup.git "$repository_directory"
fi
cd "$repository_directory"
[[ -d .my-macos-setup ]] || mv "$OLDPWD/.my-macos-setup" . 2>/dev/null || mkdir -p .my-macos-setup

# shellcheck disable=SC1091
source "$repository_directory/steps/homebrew.sh"

message 'Create an APFS snapshot before installing apps' 'step'
tmutil localsnapshot

# shellcheck disable=SC1091
source "$repository_directory/steps/apps.sh"

# shellcheck disable=SC1091
source "$repository_directory/steps/ruby.sh"

# shellcheck disable=SC1091
source "$repository_directory/steps/node.sh"

# shellcheck disable=SC1091
source "$repository_directory/steps/python.sh"

# shellcheck disable=SC1091
source "$repository_directory/steps/docker.sh"

message 'Configure global preferences'
./preferences/global.sh

message 'Configure keyboard shortcuts'
./preferences/keyboard-shortcuts.sh

message 'Configure all apps preferences'
for script in ./preferences/apps/*; do
  if [[ -x "$script" ]]; then    
    "$script"
  fi
done

message 'Finishing'
message 'Clear cache' 'step'
killall cfprefsd

setup_footer
