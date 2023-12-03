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

  message 'Add GitHub Packages token' 'step'
  message 'Enter GitHub Packages token' 'substep' 'prompt'
  read GITHUB_PACKAGES_TOKEN
  message 'Enter GitHub Packages token username' 'substep' 'prompt'
  read GITHUB_PACKAGES_TOKEN_USERNAME
  message 'Add token to `~/.zshenv`' 'substep'
  tee -a ~/.zshenv << END
# GitHub Packages read-only token
export GITHUB_PACKAGES_TOKEN=${GITHUB_PACKAGES_TOKEN}
export GITHUB_PACKAGES_TOKEN_USERNAME=${GITHUB_PACKAGES_TOKEN_USERNAME}
END
  message 'Reload .zshenv' 'substep'
  source ~/.zshenv
  message 'Add token to ~/.npmrc' 'substep'
  echo '//npm.pkg.github.com/:_authToken=${GITHUB_PACKAGES_TOKEN}' > ~/.npmrc
else
  message 'Skipping authentication' 'info'
fi

if [[ ! $@ =~ --skip-homebrew-install ]]; then
  message 'Install Homebrew' 'step'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  message 'Add Homebrew to PATH' 'substep'
  echo '# Homebrew' >> ~/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  message 'Set number of Homebrew CURL retries to 10' 'substep'
  echo 'HOMEBREW_CURL_RETRIES=10' >> ~/.zprofile
  echo '' >> ~/.zprofile
  message 'Reload .zprofile' 'substep'
  source ~/.zprofile
else
  message 'Skipping Homebrew installation' 'info'
fi

if [[ ! $@ =~ --skip-git ]]; then
  message 'Install Git from Homebrew' 'step'
  message "Currently using Git (`git --version`) at \``which git`\`" 'substep' 'info'
  message 'Install Git' 'substep'
  brew install git
  message "Currently using Git (`git --version`) at \``which git`\`" 'substep' 'info'

  message 'Clone the repository into `~/Git/krystof-k/my-macos-setup`' 'step'
  mkdir -p ~/Git/krystof-k
  cd ~/Git/krystof-k
  git clone git@github.com:krystof-k/my-macos-setup.git
  cd ./my-macos-setup
else
  message 'Skipping Git setup' 'info'
fi

message 'Create an APFS snapshot before installing apps' 'step'
tmutil localsnapshot

message 'Install apps'

message 'Install Rosetta' 'step'
sudo softwareupdate --install-rosetta

if [[ ! $@ =~ --skip-brew ]]; then
  message 'Install apps from Brewfile' 'step'
  brew bundle
else
  message 'Skipping Homebrew apps installation' 'info'
fi

if [[ ! $@ =~ --skip-ruby ]]; then
  message 'Set up Ruby'
  ./setup/ruby.sh
else
  message 'Skipping Ruby setup' 'info'
fi

message 'Set up Node.js'
./setup/node.sh
if [[ ! $@ =~ --skip-node-js ]]; then
  message 'Set up Node.js'
  ./setup/node.sh
else
  message 'Skipping Node.js setup' 'info'
fi

message 'Configure global preferences'
./preferences/global.sh

message 'Configure keyboard shortcuts'
./preferences/keyboard-shortcuts.sh
