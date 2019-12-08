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
brew update

# Install Mac App Store CLI
brew install mas
mas account
if [[ $? != 0 ]]; then
  printf "\n\nPlease sign into the Mac App Store manually."
  sleep 3
  open -a "App Store"
  sleep 15
  read -p "Press enter to continue."
fi

# Install apps in the order from README.md
brew cask install google-chrome               # Google Chrome
brew cask install visual-studio-code          # VSCode
brew cask install keka                        # Keka

# Bitwarden
printf "\n\nInstall Bitwarden manually"
sleep 15
read -p "Press enter after installation completes to continue."

mas install 441258766                         # Magnet
mas install 1000808993                        # Coca
brew cask install atext                       # aText
brew cask install vanilla                     # Vanilla
brew cask install flux                        # Flux
brew cask install lunar                       # Lunar
brew cask install slack                       # Slack

# Messenger through Nativefier
brew install yarn
yarn global add nativefier
curl 'https://raw.githubusercontent.com/krystof-k/my-macos-setup/master/nativefier/messenger.js' -o messenger.js
nativefier "https://messenger.com" --title-bar-style hidden --inject messenger.js --internal-urls 'https://www.facebook.com/checkpoint/.*'
mv Messenger-darwin-x64/Messenger.app /Applications/Messenger.app
rm -r Messenger-darwin-x64 messenger.js

brew cask install telegram                    # Telegram

# Microsoft OneNote
printf "\n\nPlease install Microsoft OneNote manually."
sleep 15
read -p "Press enter after installation completes to continue."

# Microsoft Office
printf "\n\nPlease install Microsoft Office manually."
sleep 15
read -p "Press enter after installation completes to continue."

# Adobe Creative Cloud
printf "\n\nPlease install Adobe Creative Cloud manually."
sleep 15
read -p "Press enter after installation completes to continue."

mas install 409201541                         # Pages
mas install 409203825                         # Numbers
mas install 409183694                         # Keynote
brew cask install telegram                    # Telegram

# Sketch
printf "\n\nPlease install Sketch manually."
sleep 15
read -p "Press enter after installation completes to continue."

brew cask install cyberduck                   # Cyberduck
brew cask install gifox                       # Gifox
brew cask install sourcetree                  # Sourcetree
mas install 1295203466                        # Microsoft Remote Desktop
brew cask install tunnelblick                 # Tunnelblick
brew cask install spotify                     # Spotify
brew cask install vlc                         # VLC
mas install 897118787                         # Shazam
