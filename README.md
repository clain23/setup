# Mac Setup

Automated macOS setup with Homebrew and automatic backup.

## 🚀 New Mac Setup

```bash
# Clone this repo
git clone <your-repo-url> ~/setup

# Run install
cd ~/setup
./install.sh
```

This installs Homebrew and all packages from `Brewfile`.

## 🔄 Auto-Backup Setup

Run once to enable daily automatic backups:

```bash
cd ~/setup
./setup-autobackup.sh
```

This will backup your Brewfile and commit changes every day at 8 PM.

## 📦 Manual Backup

Want to backup now? Just run:

```bash
cd ~/setup
./backup.sh
```

## 🛠️ Managing Auto-Backup

```bash
# Run backup now (don't wait for 8 PM)
launchctl start com.user.brewfile-backup

# View logs
tail -f /tmp/brewfile-backup.log

# Disable auto-backup
launchctl unload ~/Library/LaunchAgents/com.user.brewfile-backup.plist

# Re-enable auto-backup
launchctl load ~/Library/LaunchAgents/com.user.brewfile-backup.plist

# Check if running
launchctl list | grep brewfile-backup
```

## 📋 What Gets Backed Up

- **Brew packages** - CLI tools (git, node, etc.)
- **Casks** - GUI apps (Chrome, VS Code, etc.)
- **App Store apps** - via `mas` (Slack, Telegram, etc.)

## 💡 Tips

- Login to App Store before running `install.sh` for mas apps to work
- Configure git after setup:
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "your@email.com"
  ```
- To change backup time, edit the `Hour` in `~/Library/LaunchAgents/com.user.brewfile-backup.plist`

## 📁 Files

- `Brewfile` - Your packages list (auto-updated by backup script)
- `install.sh` - Fresh Mac setup
- `backup.sh` - Manual backup
- `setup-autobackup.sh` - Enable daily auto-backup