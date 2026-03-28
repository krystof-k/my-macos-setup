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

message 'Full disk access' 'step'
if plutil -lint /Library/Preferences/com.apple.TimeMachine.plist &>/dev/null; then
  message 'Already granted' 'substep' 'info'
else
  message 'Please enable full disk access for terminal and rerun the setup script' 'substep' 'prompt'
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
source "$repository_directory/stages/authentication.sh"

message 'Switch repository remote to SSH' 'step'
git remote set-url origin git@github.com:krystof-k/my-macos-setup.git

# shellcheck disable=SC1091
source "$repository_directory/stages/homebrew.sh"

message 'Create an APFS snapshot before installing apps' 'step'
tmutil localsnapshot

# shellcheck disable=SC1091
source "$repository_directory/stages/apps.sh"

# shellcheck disable=SC1091
source "$repository_directory/stages/ruby.sh"

# shellcheck disable=SC1091
source "$repository_directory/stages/node.sh"

# shellcheck disable=SC1091
source "$repository_directory/stages/python.sh"

# shellcheck disable=SC1091
source "$repository_directory/stages/docker.sh"

# shellcheck disable=SC1091
source "$repository_directory/stages/global-preferences.sh"

# shellcheck disable=SC1091
source "$repository_directory/stages/keyboard-shortcuts.sh"

# shellcheck disable=SC1091
source "$repository_directory/stages/app-preferences.sh"

message 'Finishing'
message 'Reload preferences cache' 'step'
killall -HUP cfprefsd

setup_footer
