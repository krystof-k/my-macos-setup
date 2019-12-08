# Install Xcode Command Line Tools
xcode-select --install
echo "Waiting for Xcode Command Line Tools to be installed."
read -p "Please press enter after installation completes to continue."

# Install & update Homebrew
which -s brew
if [[ $? != 0 ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update
brew upgrade

# Install Mac App Store CLI
brew install mas

# Install apps in the order from README.md
brew cask install google-chrome               # Google Chrome
brew cask install visual-studio-code          # VSCode
brew cask install keka                        # Keka
mas install 441258766                         # Magnet
mas install 1000808993                        # Coca
brew cask install atext                       # aText
brew cask install vanilla                     # Vanilla
brew cask install flux                        # Flux
brew cask install lunar                       # Lunar
brew cask install slack                       # Slack
brew cask install telegram                    # Telegram
echo "Install Microsoft OneNote manually"     # Microsoft OneNote
echo "Install Microsoft Office manually"      # Microsoft Office
echo "Install Adobe Creative Cloud manually"  # Adobe Creative Cloud
mas install 409201541                         # Pages
mas install 409203825                         # Numbers
mas install 409183694                         # Keynote
brew cask install telegram                    # Telegram
echo "Install Sketch manually"                # Sketch
brew cask install cyberduck                   # Cyberduck
brew cask install gifox                       # Gifox
brew cask install sourcetree                  # Sourcetree
mas install 1295203466                        # Microsoft Remote Desktop
brew cask install tunnelblick                 # Tunnelblick
brew cask install spotify                     # Spotify
brew cask install vlc                         # VLC
mas install 897118787                         # Shazam
