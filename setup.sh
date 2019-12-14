#!/usr/bin/env bash

# Install Xcode Command Line Tools
xcode-select -p
if [[ $? != 0 ]]; then
  echo " Xcode Command Line Tools are not installed. Please continue with the installation."
  xcode-select --install
  sleep 15
  echo " Waiting for Xcode Command Line Tools to be installed."
  sleep 15
  read -p " Press enter after installation completes to continue."
fi

# Create Git folder
echo " Creating ~/Git folder."
mkdir -p ~/Git
