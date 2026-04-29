# Manual Sync Instructions

## GitHub Push Needs Authentication

The git repository is initialized and committed locally, but pushing to GitHub requires authentication.

### Option 1: Personal Access Token (Recommended)

1. **Generate token:**
   - Go to https://github.com/settings/tokens
   - Generate new token → classic
   - Name: "OpenClaw Brain Sync"
   - Scopes: `repo` (full control)

2. **Update the push script:**
   ```bash
   # Edit this file and insert your token where it says YOUR_GITHUB_TOKEN_HERE
   # Then run:
   /tmp/push_with_auth.sh
   ```

### Option 2: SSH Key Setup

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "claw@openclaw.local"

# Copy public key to clipboard
cat ~/.ssh/id_ed25519.pub

# Add to GitHub: https://github.com/settings/keys

# Update remote URL
cd /home/ubuntu/.openclaw/workspace
git remote set-url origin git@github.com:YearsAlso/openclaw-memory-sync.git

# Push
git push origin master
```

### Verify Sync

After successful push, the files should be at:
https://github.com/YearsAlso/openclaw-memory-sync

## Cron Setup (For Future Auto-Sync)

Once GitHub push works, run this to enable auto-sync every 10 minutes:

```bash
chmod +x /home/ubuntu/.openclaw/workspace/brain/add_cron.sh
/home/ubuntu/.openclaw/workspace/brain/add_cron.sh
```

## Manual Sync Anytime

```bash
/home/ubuntu/.openclaw/workspace/brain/sync.sh
```

---

**Current status:** 14 files committed locally, awaiting GitHub authentication.
