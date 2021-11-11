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

brew bundle

brew autoupdate --start 43200 --upgrade --cleanup --enable-notification

# VSCode setup

code --install-extension bbenoist.vagrant
code --install-extension formulahendry.code-runner
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-vscode.PowerShell
code --install-extension shakram02.bash-beautify
code --install-extension timonwong.shellcheck
code --install-extension mauve.terraform
code --install-extension oderwat.indent-rainbow
code --install-extension dmitrydorofeev.empty-indent
code --install-extension github.copilot


# zsh setup

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc):
# plugins=(zsh-autosuggestions)

#minikube setup

minikube config set vm-driver hyperkit
minikube config set memory 4096

#todo
#https://gist.github.com/kevin-smets/8568070


# disable mouse acceleration to be more like windows style
defaults write .GlobalPreferences com.apple.mouse.scaling -1

# update OS
softwareupdate --all --install --force