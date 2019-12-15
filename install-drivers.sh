# Install Xcode Command Line Tools
xcode-select -p
if [[ $? != 0 ]]; then
  xcode-select --install
  echo " Waiting for Xcode Command Line Tools to be installed."
  sleep 15
  echo " Press enter after installation completes to continue."
  read _
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
echo " Installation of Logi Options will continue."
echo " Be aware of pop-up windows and special permissions to finish the installation."
sleep 3
brew cask install logitech-options

# Logitech Control Center
echo " Installation of Logitech Control Center will continue."
echo " Be aware of pop-up windows and special permissions to finish the installation."
sleep 3
brew cask install logitech-control-center
