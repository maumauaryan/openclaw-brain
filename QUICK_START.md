# Mission Control - Quick Start Guide

## Access

**Mission Control Dashboard:** http://localhost:3000
**API Key:** `ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a`
**Gateway:** http://127.0.0.1:18789 (Token: `0c7e5ffce8ce20c417a37acfe020ae1cc0dbfe5bda7d3c33`)

## Services Status

| Service | Status | Port | Access |
|---------|--------|------|--------|
| Mission Control | ✅ Running | 3000 | http://localhost:3000 |
| OpenClaw Gateway | ✅ Running | 18789 | http://127.0.0.1:18789 |
| Hermes | ✅ Running | - | CLI: `hermes` |
| Memory Sync | ✅ Scheduled | - | Every 5 minutes |

## First 5 Minutes

### 1. Log in to Mission Control
```
URL: http://localhost:3000
Username: aryan
Password: [you know it or reset via database]
```

### 2. Check Gateway Connection
- Navigate to: **Gateways** panel
- Should show: OpenClaw Gateway on 127.0.0.1:18789
- Status: Connected (green)

### 3. View Agents
- Navigate to: **Agents** panel
- You'll see: coordinator, main, dogfood, yuanbao
- Status: offline (until assigned a task)

### 4. Create a Test Task
- Navigate to: **Tasks** panel
- Click: **New Task**
- Fill in:
  - Title: "Test Agent Execution"
  - Description: "Give the main agent a simple task to verify the system works"
  - Priority: High
  - Assigned to: main
- Click: **Create**
- Watch: Task moves through inbox → in progress → done

### 5. Check Memory
- Navigate to: **Memory** panel
- Search for: "agency pricing"
- Should return: Context from MEMORY.md

## CLI Quick Reference

```bash
# Source environment (optional, use in ~/.bashrc)
export MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
export MC_URL="http://localhost:3000"

cd /home/ubuntu/mission-control

# Tasks
pnpm mc tasks list                              # List tasks
pnpm mc tasks create --title "..."              # Create task
pnpm mc tasks get --task-id <id>                # Get task details

# Agents
pnpm mc agents list                             # List agents
pnpm mc agents get --agent-id <id>              # Get agent details
pnpm mc agents wake --agent-id <id> --m "..."   # Wake agent with message

# Cron
pnpm mc cron list                               # List scheduled tasks
pnpm mc cron create                             # Create scheduled task

# Memory
pnpm mc memory search --query "..."             # Search memory
```

## Memory System

### Memory Paths
- **Long-term:** `/home/ubuntu/.openclaw/MEMORY.md`
- **Daily logs:** `/home/ubuntu/.openclaw/memory/YYYY-MM-DD.md`
- **Shared:** `/home/ubuntu/shared-memory/`
- **HEARTBEAT:** `/home/ubuntu/.openclaw/HEARTBEAT.md`

### Memory Sync
- Runs automatically every 5 minutes
- Script: `/home/ubuntu/sync-memory.sh`
- Syncs: OpenClaw ↔ Hermes ↔ Mission Control
- Logs: `/tmp/memory-sync.log`

### Access Memory
- **Dashboard:** Memory panel (search + browsing)
- **API:** `/api/memory/search?query=...`
- **Agents:** `memory_search("query")` from agent code

## Common Tasks

### Assign a Task to an Agent

**Via Dashboard:**
1. Go to Tasks panel
2. Create or select a task
3. Click "Assign" → choose agent

**Via CLI:**
```bash
pnpm mc tasks create \
  --title "Research competitor" \
  --description "Analyze competitor X for pricing and positioning" \
  --assigned-to researcher \
  --priority high
```

### View Agent Memory

**Via Dashboard:**
1. Go to Agents panel
2. Click on agent
3. Navigate to Memory tab

**Via CLI:**
```bash
pnpm mc agents memory --agent-id <id> --action get
```

### Schedule Recurring Task

```bash
curl -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Daily Briefing",
    "description": "Check previous day activity",
    "schedule": "every morning at 7am",
    "assigned_to": "coordinator"
  }' \
  "http://localhost:3000/api/cron"
```

## Stopping / Starting Services

```bash
# Mission Control
cd /home/ubuntu/mission-control
pnpm start    # Start (runs in foreground, use nohup for background)
# Or use: /home/ubuntu/start-mission-control.sh

# OpenClaw Gateway
openclaw gateway start    # Start
openclaw gateway stop     # Stop
openclaw gateway restart  # Restart
openclaw gateway status   # Check status

# Hermes
hermes                    # Start CLI session
hermes --help             # Help

# Memory Sync
/home/ubuntu/sync-memory.sh    # Run manually
# Scheduled via cron, no need to start/stop
```

## Troubleshooting

### Mission Control not accessible
```bash
# Check if running
ps aux | grep "next start"

# Restart
cd /home/ubuntu/mission-control
pkill -f "next start"
pnpm start

# Check logs
tail -f /tmp/mission-control.log
```

### Gateway not connected
```bash
# Check gateway status
openclaw gateway status

# Restart
openclaw gateway restart

# View logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

### Agent not responding
```bash
# Check agent status
pnpm mc agents list

# Wake agent manually
pnpm mc agents wake --agent-id <id> --message "Check status"

# Check logs
cd /home/ubuntu/mission-control/.data
tail -f mission-control.db
```

### Memory not syncing
```bash
# Check memory sync log
tail -f /tmp/memory-sync.log

# Run manually
/home/ubuntu/sync-memory.sh

# Check directories
ls -lh /home/ubuntu/.openclaw/memory/
ls -lh /home/ubuntu/shared-memory/
```

## Key Files Reference

| File | Purpose |
|------|---------|
| `/home/ubuntu/.openclaw/workspace/PRODUCTION_SETUP.md` | Full setup documentation |
| `/home/ubuntu/.openclaw/workspace/QUICK_START.md` | This file |
| `/home/ubuntu/.openclaw/workspace/mission-control-info.md` | Original setup info |
| `/home/ubuntu/.openclaw/HEARTBEAT.md` | Memory automation scheduler |
| `/home/ubuntu/mission-control/.env` | Mission Control config |
| `/home/ubuntu/.openclaw/openclaw.json` | OpenClaw config |
| `/home/ubuntu/.hermes/config.yaml` | Hermes config |

## Documentation Online

- **Mission Control:** https://github.com/builderz-labs/mission-control
- **OpenClaw:** https://docs.openclaw.ai
- **Your Setup:** Local files in `~/.openclaw/workspace/`

## Support

Check logs for issues:
- Mission Control: `/tmp/mission-control.log`
- OpenClaw Gateway: `/tmp/openclaw/openclaw-YYYY-MM-DD.log`
- Memory Sync: `/tmp/memory-sync.log`

---

**Last Updated:** 2026-04-30 12:01 UTC
**System Status:** ✅ All systems operational
