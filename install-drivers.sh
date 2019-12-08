# Install Xcode Command Line Tools
xcode-select -p
if [[ $? != 0 ]]; then
  xcode-select --install
  printf "\n\nWaiting for Xcode Command Line Tools to be installed."
  sleep 15
  read -p "Press enter after installation completes to continue."
fi

# Install & update Homebrew
which -s brew
if [[ $? != 0 ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew tap homebrew/cask-drivers
brew update
brew upgrade

# Install drivers in the order from README.md
printf "\n\nInstallation of Logi Options will continue."
printf "Be aware of pop-up windows and special permissions to finish the installation."
sleep 3
brew cask install logitech-options        # Logi Options
printf "\n\nInstallation of Logitech Control Center will continue."
printf "Be aware of pop-up windows and special permissions to finish the installation."
sleep 3
brew cask install logitech-control-center # Logitech Control Center
