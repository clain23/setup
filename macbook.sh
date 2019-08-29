# Install Homebrew

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install software

brew update
brew cask install 1password
brew cask install adobe-acrobat-reader
brew cask install caffeine
brew cask install docker
brew cask install google-chrome
brew cask install powershell
#brew cask install telegram #rkn problems
brew cask install visual-studio-code

# Setup autoupdate

brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notification
