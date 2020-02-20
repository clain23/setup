#!/bin/sh

# Install Dev tools

xcode-select --install
sleep 1
osascript <<EOD
  tell application "System Events"
    tell process "Install Command Line Developer Tools"
      keystroke return
      click button "Agree" of window "License Agreement"
    end tell
  end tell
EOD

# Install Homebrew

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install software

brew update

# should rewrite to use https://github.com/Homebrew/homebrew-bundle

brew install bash-completion
brew install gcc
brew install github/gh/gh 
brew install htop
brew install minikube
brew install packer
brew install shellcheck
brew install ssh-copy-id
brew install terminal-notifier
brew install terraform

brew cask install 1password
brew cask install adobe-acrobat-reader
brew cask install aerial # screensaver
brew cask install caffeine
brew cask install cloudapp
brew cask install docker
brew cask install google-chrome
brew cask install google-drive-file-stream
brew cask install microsoft-office
brew cask install multipass
brew cask install powershell
#brew cask install telegram #rkn problems
brew cask install virtualbox
brew cask install visual-studio-code

brew tap instrumenta/instrumenta
brew install kubeval

# Setup Brew autoupdate

brew tap domt4/autoupdate
brew autoupdate --start --upgrade --cleanup --enable-notification

# VSCode setup

code --install-extension bbenoist.vagrant
code --install-extension formulahendry.code-runner
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode.PowerShell
code --install-extension shakram02.bash-beautify
code --install-extension timonwong.shellcheck
code --install-extension mauve.terraform

# zsh setup

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

#minikube setup

minikube config set vm-driver hyperkit
minikube config set memory 4096

#todo
#https://gist.github.com/kevin-smets/8568070
