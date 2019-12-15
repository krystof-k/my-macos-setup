#!/usr/bin/env bash

# Install Xcode Command Line Tools
xcode-select -p
if [[ $? != 0 ]]; then
  echo " Xcode Command Line Tools are not installed. Please continue with the installation."
  xcode-select --install
  sleep 15
  echo " Waiting for Xcode Command Line Tools to be installed."
  sleep 60
  echo " Press enter after installation completes to continue."
  read _
fi

# Create Git folder
echo " Creating ~/Git folder."
mkdir -p ~/Git

# Clone the repository 
echo " Cloning the repository into ~/Git folder."
cd ~/Git
git clone https://github.com/krystof-k/my-macos-setup.git
cd ./my-macos-setup

# Install apps
bash ./install-apps.sh

# Install drivers
bash ./install-drivers.sh

# Setup preferences
bash ./setup-preferences.sh

# Setup Git defaults
git config --global user.name 'Kryštof Korb'
git config --global user.email 'krystof@korb.cz'

# Purge cache
killall cfprefsd

# Reboot
echo " Setup complete. Rebooting in 15 seconds."
echo " Open ~/Git/my-macos-setup/to-do.txt and proceeed with manual steps after reboot."
sleep 15
sudo reboot
