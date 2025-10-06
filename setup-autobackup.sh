#!/bin/bash

# Setup script for automatic Brewfile backup via launchd

set -e

PLIST_FILE="$HOME/Library/LaunchAgents/com.user.brewfile-backup.plist"
BACKUP_SCRIPT="$HOME/setup/backup.sh"
LABEL="com.user.brewfile-backup"

echo "🔧 Setting up automatic Brewfile backup..."

# Check if backup script exists
if [ ! -f "$BACKUP_SCRIPT" ]; then
    echo "❌ Error: backup.sh not found at $BACKUP_SCRIPT"
    exit 1
fi

# Make backup script executable
chmod +x "$BACKUP_SCRIPT"

# Create LaunchAgents directory if it doesn't exist
mkdir -p "$HOME/Library/LaunchAgents"

# Create the plist file
echo "📝 Creating launchd configuration..."
cat > "$PLIST_FILE" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.brewfile-backup</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>-c</string>
        <string>$HOME/setup/backup.sh</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>20</integer>
        <key>Minute</key>
        <integer>0</integer>
    </dict>
    <key>StandardOutPath</key>
    <string>/tmp/brewfile-backup.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/brewfile-backup.err</string>
</dict>
</plist>
EOF

# Unload if already loaded (to reload with new config)
if launchctl list | grep -q "$LABEL"; then
    echo "♻️  Reloading existing service..."
    launchctl unload "$PLIST_FILE" 2>/dev/null || true
fi

# Load the launch agent
echo "🚀 Loading launch agent..."
launchctl load "$PLIST_FILE"

# Verify it's loaded
if launchctl list | grep -q "$LABEL"; then
    echo "✅ Success! Automatic backup is now configured."
    echo ""
    echo "📅 Backup will run daily at 8:00 PM"
    echo ""
    echo "Useful commands:"
    echo "  - Run backup now:    launchctl start $LABEL"
    echo "  - View logs:         tail -f /tmp/brewfile-backup.log"
    echo "  - Disable service:   launchctl unload $PLIST_FILE"
    echo "  - Re-enable service: launchctl load $PLIST_FILE"
else
    echo "❌ Error: Failed to load launch agent"
    exit 1
fi
