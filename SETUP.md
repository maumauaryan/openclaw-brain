# Brain Setup — Linux Environment

## Current Status

**Server:** Ubuntu EC2 at `/home/ubuntu/.openclaw/workspace/brain/`
**Sync strategy:** Obsidian plugin for local work + GitHub for remote sync

## File Locations

```
/home/ubuntu/.openclaw/workspace/brain/
├── INDEX.md           → Central hub
├── SOUL.md            → Agent philosophy
├── IDENTITY.md        → Claw 🦞
├── USER.md            → About Aryan
├── MEMORY.md          → Long-term knowledge
├── AGENTS.md          → Operating rules
├── HEARTBEAT.md       → Automated checks
└── skills/
    ├── lead-researcher/SKILL.md
    ├── dm-drafter/SKILL.md
    └── hook-generator/SKILL.md
```

## Sync Architecture

### 1. Server ↔ GitHub (Continuous)
- Automated git commits when brain files change
- Push to `YearsAlso/openclaw-memory-sync` repo
- Pull from any machine that has access

### 2. Local Machine ↔ Obsidian (Plugin)
- Install the OpenClaw Memory Sync plugin in Obsidian
- Connect to: `localhost:18789` (or your gateway URL)
- Target folder: `brain/`
- Auto-sync every 5 minutes

### 3. Bidirectional Flow

```
Local Obsidian  ←→  GitHub Repo  ←→  Server Brain Files
     ↑                                        ↑
 Plugin runs                Agent updates here
```

## Using the OpenClaw Memory Sync Plugin

### Install (On Your Local Machine)

1. **Download plugin:**
   ```bash
   cd ~/Downloads
   git clone https://github.com/YearsAlso/openclaw-memory-sync
   ```

2. **Move to Obsidian plugins:**
   - Windows: `%APPDATA%\obsidian\plugins\openclaw-memory-sync\`
   - macOS: `~/Library/Application Support/obsidian/plugins/openclaw-memory-sync/`
   - Linux: `~/.config/obsidian/plugins/openclaw-memory-sync/`

3. **Enable in Obsidian:**
   - Settings → Community Plugins → Enable "OpenClaw Memory Sync"

### Configure Plugin

In Obsidian plugin settings:

```yaml
API Address: [your-server-ip]
API Port: 18789
API Token: [your OpenClaw token - if auth enabled]
Target Folder: brain/
Sync Interval: 300 (5 minutes)
Auto Sync: Enabled
```

## Server-Side Auto-Sync Setup

Create a cron job to commit brain changes to GitHub:

```bash
crontab -e
```

Add this line (every 10 minutes):

```cron
*/10 * * * * cd /home/ubuntu/.openclaw/workspace && git add -A brain/ && git commit -m "Auto-sync: brain update $(date +\%Y-\%m-\%d \%H:\%M)" && git push origin main 2>&1 | logger -t openclaw-sync
```

## Troubleshooting

### Plugin can't connect to server

**Check if gateway is running:**
```bash
ps aux | grep openclaw-gateway
```

**Check firewall access:**
```bash
sudo ufw allow 18789/tcp
```

**Test API endpoint:**
```bash
curl http://localhost:18789/
```

### GitHub sync not working

**Check git credentials:**
```bash
cd /home/ubuntu/.openclaw/workspace
git remote -v
git config user.name
git config user.email
```

**Manual sync test:**
```bash
git pull origin main
git push origin main
```

---

**Result:** Changes anywhere → sync everywhere. Obsidian graph view shows live connections across all devices.
