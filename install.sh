#!/bin/bash

# Quick setup script for a new Mac

set -e

echo "🚀 Starting Mac setup..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "🍺 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # For Apple Silicon, add brew to PATH
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✅ Homebrew already installed"
fi

# Check if mas is installed
if ! command -v mas &> /dev/null; then
    echo "📱 Installing mas (Mac App Store CLI)..."
    brew install mas
fi

# Install packages from Brewfile
echo "📦 Installing packages from Brewfile..."
brew bundle --file="$HOME/setup/Brewfile"

echo "✅ Done! All packages installed."
echo ""
echo "💡 Don't forget to:"
echo "  - Login to App Store to install mas apps"
echo "  - Configure git: git config --global user.name & user.email"
echo "  - Run backup.sh setup for auto-updates"
