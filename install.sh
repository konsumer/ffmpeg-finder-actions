#!/usr/bin/env bash
# Installs all ffmpeg Finder Quick Actions into ~/Library/Services/
# Usage: bash install.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
WORKFLOWS_DIR="$SCRIPT_DIR/workflows"
SERVICES_DIR="$HOME/Library/Services"

if [ ! -d "$WORKFLOWS_DIR" ]; then
  echo "No workflows/ directory found."
  exit 1
fi

mkdir -p "$SERVICES_DIR"

count=0
for w in "$WORKFLOWS_DIR"/*.workflow; do
  name="$(basename "$w")"
  dest="$SERVICES_DIR/$name"
  if [ -d "$dest" ]; then
    rm -rf "$dest"
  fi
  cp -r "$w" "$SERVICES_DIR/"
  echo "  Installed: $name"
  count=$((count + 1))
done

echo ""
echo "Installed $count Quick Actions to: $SERVICES_DIR"
echo ""
echo "Next steps:"
echo "  1. Make sure ffmpeg is installed: brew install ffmpeg"
echo "  2. Right-click any file in Finder"
echo "  3. Look under Quick Actions (or Services) in the context menu"
echo ""
echo "If the actions don't appear immediately, open:"
echo "  System Settings -> Privacy & Security -> Extensions -> Finder Extensions"
echo "  and enable the ones you want."
