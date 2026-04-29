#!/bin/bash
# Auto-sync brain files to GitHub
# Run this periodically via cron or manually

cd /home/ubuntu/.openclaw/workspace

# Check for changes
if git diff --quiet && git diff --cached --quiet; then
    echo "$(date): No changes to sync"
    exit 0
fi

# Add all brain files
git add -A brain/

# Commit with timestamp
git commit -m "Auto-sync: brain update $(date +%Y-%m-%d\ %H:%M:%S)"

# Push to GitHub
git push origin main

echo "$(date): Brain synced to GitHub"
