# Install Xcode Command Line Tools
xcode-select -p
if [[ $? != 0 ]]; then
  xcode-select --install
  printf "\nWaiting for Xcode Command Line Tools to be installed.\n"
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

# Install drivers in the order from README.md

# Logi Options
printf "\nInstallation of Logi Options will continue.\n"
printf "Be aware of pop-up windows and special permissions to finish the installation."
sleep 3
brew cask install logitech-options

# Logitech Control Center
printf "\nInstallation of Logitech Control Center will continue.\n"
printf "Be aware of pop-up windows and special permissions to finish the installation."
sleep 3
brew cask install logitech-control-center
