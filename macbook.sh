#!/bin/sh

# Install Homebrew

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install software

brew update

brew install shellcheck
brew install terminal-notifier

brew cask install 1password
brew cask install adobe-acrobat-reader
brew cask install caffeine
brew cask install docker
brew cask install google-chrome
brew cask install powershell
#brew cask install telegram #rkn problems
brew cask install visual-studio-code

# Setup Brew autoupdate

brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notification

# VSCode setup

code --install-extension formulahendry.code-runner
code --install-extension ms-vscode.PowerShell
code --install-extension shakram02.bash-beautify
code --install-extension timonwong.shellcheck
