#!/bin/bash

# Automatic Brewfile backup and commit script

set -e

REPO_DIR="$HOME/setup"
cd "$REPO_DIR"

echo "🍺 Dumping Brewfile..."
brew bundle dump --force --describe

echo "📦 Checking for changes..."
if git diff --quiet Brewfile; then
    echo "✅ No changes in Brewfile"
    exit 0
fi

echo "📝 Committing changes..."
git add Brewfile
git commit -m "Auto-update Brewfile - $(date '+%Y-%m-%d %H:%M:%S')"

echo "🚀 Pushing to repo..."
if git push; then
    echo "✅ Successfully pushed!"
else
    echo "⚠️  Failed to push (maybe no internet), will try next time"
    exit 1
fi
