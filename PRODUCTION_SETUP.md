# Mission Control Production Setup - Complete Guide

## System Status
- ✅ Mission Control running: http://localhost:3000
- ✅ OpenClaw Gateway running: http://127.0.0.1:18789
- ✅ Gateway Token: `0c7e5ffce8ce20c417a37acfe020ae1cc0dbfe5bda7d3c33`
- ✅ API Key: `ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a`

## Memory System Integration

### Memory Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    MEMORY SYSTEM LAYERS                      │
├─────────────────────────────────────────────────────────────┤
│  1. Session-Level Memory (ephemeral)                          │
│     - Current conversation context                           │
│     - Hyper-context: Workspace, skills, AGENTS.md           │
│     - Project inject: All project context files              │
│                                                              │
│  2. Long-Term Memory (persistent)                             │
│     - MEMORY.md: Core knowledge, agency context              │
│     - memory/YYYY-MM-DD.md: Daily logs                       │
│     - HEARTBEAT.md: Automated memory engine                  │
│     - Indexed via vector search in metadata store            │
│                                                              │
│  3. Multi-System Sync                                         │
│     ├─ OpenClaw: ~/.openclaw/memory/ + MEMORY.md            │
│     ├─ Hermes: ~/.hermes/memory/ (SQLite + vector)           │
│     └─ Mission Control: SQLite DB + memory browser          │
└─────────────────────────────────────────────────────────────┘
```

### Memory Paths Configuration

#### OpenClaw Memory
```bash
# Long-term memory files
/home/ubuntu/.openclaw/
├── MEMORY                    # Main memory database (Indexed)
├── memory/
│   ├── YYYY-MM-DD.md        # Daily episodic memory
│   └── ...
├── workspace/
│   ├── AGENTS.md           # Agent definitions
│   ├── SOUL.md             # Agent personality
│   ├── IDENTITY.md         # Who I am
│   ├── USER.md             # About Aryan
│   ├── TOOLS.md            # Environment-specific notes
│   └── PRODUCTION_SETUP.md # This file
└── HEARTBEAT.md            # Automated memory scheduler
```

#### Hermes Memory
```bash
# Hermes stores memory in SQLite with vector embeddings
/home/ubuntu/.hermes/
├── hermes-memory.db         # SQLite database with memory tables
├── memory/                  # Additional file-based memory
└── vector-store/            # Vector embeddings for semantic search
```

#### Mission Control Memory
```bash
# Mission Control integrates with OpenClaw memory
/home/ubuntu/mission-control/.data/
├── mission-control.db      # SQLite with agents, tasks, memory logs
└── memory-browser/         # Cached memory search results
```

### Wiring Memory Systems Together

#### 1. Shared Memory Directory (Recommended)

Create a shared memory mount accessible by all systems:

```bash
# Create shared memory directory
mkdir -p /home/ubuntu/shared-memory/{long-term,episodic,daily}

# Configure OpenClaw to use shared memory
cat >> /home/ubuntu/.openclaw/openclaw.json << 'EOF'
{
  "memory": {
    "sharedPath": "/home/ubuntu/shared-memory",
    "ephisodialPath": "/home/ubuntu/shared-memory/episodic",
    "dailyPath": "/home/ubuntu/shared-memory/daily"
  }
}
EOF

# Configure Hermes to use shared memory
cat >> /home/ubuntu/.hermes/config.yaml << 'EOF'
memory:
  shared_path: /home/ubuntu/shared-memory
  enable_sync: true
  sync_interval_minutes: 5
EOF
```

#### 2. Memory Bridge Script

Create a script that syncs memory between systems:

```bash
#!/bin/bash
# /home/ubuntu/sync-memory.sh - Sync memory between OpenClaw, Hermes, and Mission Control

OPENCLAW_MEMORY="/home/ubuntu/.openclaw"
HERMES_MEMORY="/home/ubuntu/.hermes"
SHARED_MEMORY="/home/ubuntu/shared-memory"
MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
MC_URL="http://localhost:3000"

# Function to log to memory
log-memory() {
    local context="$1"
    local analysis="$2"
    local action="$3"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Log to OpenClaw daily memory
    local date_str=$(date -u +"%Y-%m-%d")
    local memory_file="$OPENCLAW_MEMORY/memory/$date_str.md"

    echo "## [$timestamp] $context" >> "$memory_file"
    echo "" >> "$memory_file"
    echo "**Analysis:** $analysis" >> "$memory_file"
    echo "" >> "$memory_file"
    echo "**Action:** $action" >> "$memory_file"
    echo "" >> "$memory_file"
    echo "---" >> "$memory_file"
    echo "" >> "$memory_file"

    # Log to Mission Control
    curl -s -X POST \
        -H "x-api-key: $MC_API_KEY" \
        -H "Content-Type: application/json" \
        -d "{\"context\":\"$context\",\"analysis\":\"$analysis\",\"action\":\"$action\"}" \
        "$MC_URL/api/memory" > /dev/null 2>&1

    echo "Logged to memory: $context"
}

# Sync memory from OpenClaw to Hermes
sync-openclaw-to-hermes() {
    echo "Syncing OpenClaw memory to Hermes..."

    # Copy MEMORY.md
    cp "$OPENCLAW_MEMORY/MEMORY.md" "$HERMES_MEMORY/memory/" 2>/dev/null

    # Copy episodic memory
    rsync -av "$OPENCLAW_MEMORY/memory/" "$SHARED_MEMORY/daily/" 2>/dev/null

    echo "OpenClaw memory synced"
}

# Log a memory entry
log-memory "Memory System Sync" "Synced memory from OpenClaw to Hermes and Mission Control" "sync-memory.sh executed"

# Run sync
sync-openclaw-to-hermes

echo "Memory sync complete"
```

Make it executable and schedule:

```bash
chmod +x /home/ubuntu/sync-memory.sh
# Schedule every 5 minutes
(crontab -l 2>/dev/null; echo "*/5 * * * * /home/ubuntu/sync-memory.sh >> /tmp/memory-sync.log 2>&1") | crontab -
```

#### 3. Memory Access from Agents

Agents can access memory via:

**OpenClaw Agents:**
- `memory_search(query)` - Semantic search across MEMORY.md + memory/*.md
- `memory_get(path, from, lines)` - Read specific memory files
- Direct file access to workspace context (MEMORY, AGENTS, etc.)

**Hermes Agents:**
- Utterance check discovered via memory_search
- Configured with `memory_enabled: true`
- Auto-flush after defined turns

**Mission Control:**
- Memory panel shows OpenClaw memory
- `/api/memory/search` endpoint
- `/api/memory/context` endpoint

### Memory Usage Examples

#### Example 1: Agency Context Retention

```bash
# Agent recalls agency positioning via MEMORY.md
memory_search("agency positioning offers pricing")

# Returns references to:
# - $8K-10K/month retainer pricing
# - Authority Sprint / Authority Build offers
# - US/UK/Canada/Australia target clients
# - DM + Loom outreach strategy
```

#### Example 2: Daily Activity Logging

```bash
# HEARTBEAT.md automation writes daily logs
# File: /home/ubuntu/.openclaw/memory/2026-04-30.md

## [2026-04-30T11:00:00Z] Morning Briefing

**Analysis:**
- Checked pending items from yesterday
- Found 3 hot leads not yet contacted
- Compiled today's top 3 priorities

**Action:**
- Created memory/2026-04-30.md with morning log
- surfaced DM replies requiring response

---
```

#### Example 3: Cross-Session Memory Access

```bash
# Agent can access memory from previous sessions
memory_search "Aryan's timezone preferred communication style"

# Returns from USER.md:
# - Timezone: IST (Asia/Kolkata, UTC+5:30)
# - Communication: Fast, direct, no filler
# - Style: Peer-level, no hedging
```

## Production Configuration

### Gateway Connection

Connect Mission Control to OpenClaw Gateway:

```bash
# Source these variables for all MC CLI commands
export MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
export MC_URL="http://localhost:3000"
export OC_GATEWAY_TOKEN="0c7e5ffce8ce20c417a37acfe020ae1cc0dbfe5bda7d3c33"
export OC_GATEWAY_HOST="127.0.0.1"
export OC_GATEWAY_PORT="18789"

# Test gateway connection
curl -s http://127.0.0.1:18789/status
# Expected: {"gateway":"ready","agents":[]}
```

### Agent Configuration

#### 1. Main Operator Agent

```bash
cd /home/ubuntu/mission-control
export MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
export MC_URL="http://localhost:3000"

# Create main operator
pnpm mc agents create \
  --name main \
  --role operator \
  --soul "You're Claw,Aryan's systems partner.Sharp,direct,no fluff.Peer-level tone.Founder-to-founder communication.Read MEMORY.md for agency context.Use memory_search before answering contextual questions." \
  --config '{"model":"amazon-bedrock/zai.glm-4.7","toolsProfile":"coding"}'
```

#### 2. Research Agent

```bash
pnpm mc agents create \
  --name researcher \
  --role research \
  --soul "Research specialist.Log findings to memory.Searches memory for previous research before starting new tasks.Creates comprehensive reports in shared memory."
```

#### 3. Content Agent

```bash
pnpm mc agents create \
  --name content \
  --role content \
  --soul "Content creation specialist.Reads CONTENT_OS from memory.Produces B-roll voiceover specs in agency format.Amber,Cream,Black palette.Syne Bold + DM Sans fonts."
```

### Task Creation & Testing

```bash
# Create a test task
pnpm mc tasks create \
  --title "Test Agent Assignment" \
  --description "Verify agent can access memory and respond" \
  --assigned-to main \
  --priority high

# Monitor tasks
pnpm mc tasks list

# View task details
pnpm mc tasks get --task-id <task-id>
```

### Cron Jobs (Automated Tasks)

Mission Control cron jobs schedule recurring work:

```bash
# Create daily check-in job
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Daily Morning Briefing",
    "description": "Check previous day activity, surface leads, compile priorities",
    "schedule": "every morning at 7am",
    "assigned_to": "coordinator"
  }' \
  "$MC_URL/api/cron"

# Create client discovery job
curl -s -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Client Discovery & Outreach",
    "description": "Research and identify potential $100K+/month founders for outreach",
    "schedule": "every morning at 10am",
    "assigned_to": "researcher"
  }' \
  "$MC_URL/api/cron"
```

## Memory System Testing

### Test 1: Memory Search

```bash
# From OpenClaw session
memory_search "Aryan agency pricing offers"

# Should return context about:
# - $8K-10K/month retainers
# - Authority Sprint (3mo)
# - Authority Build (6mo)
```

### Test 2: Memory Write

```bash
# Agent writes to memory
# This creates daily log entry
echo "
## [$(date -u +%Y-%m-%dT%H:%M:%SZ)] Memory Test

**Context:** Testing memory write capability

**Analysis:** Successfully wrote test entry to episodic memory

**Action:** Tested memory_write from mission control context

---" >> /home/ubuntu/.openclaw/memory/$(date +%Y-%m-%d).md
```

### Test 3: Cross-System Access

```bash
# Check if MC can read OpenClaw memory
curl -s -H "x-api-key: $MC_API_KEY" \
  "$MC_URL/api/memory/search?query=agency+pricing"

# Should return semantic search results
```

## Monitoring & Observability

### 1. Mission Control Dashboard

Access at: http://localhost:3000

Key Panels:
- **Tasks**: Kanban board for task tracking
- **Agents**: Agent status, last seen, heartbeats
- **Sessions**: Live transcripts, cross-session messaging
- **Memory**: Browser, search, graph visualization
- **Logs**: Activity stream with semantic search
- **Tokens**: Cost tracking per agent/model
- **Security**: Trust scores, secret detection

### 2. Gateway Health

```bash
# Check gateway status
curl -s http://127.0.0.1:18789/status

# Check agent registrations
curl -s http://127.0.0.1:18789/api/agents

# View gateway logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

### 3. Memory System Health

```bash
# Check OpenClaw memory
ls -lh /home/ubuntu/.openclaw/memory/
du -sh /home/ubuntu/.openclaw/memory/

# Check Hermes memory
sqlite3 ~/.hermes/hermes-memory.db "SELECT COUNT(*) FROM memory;"

# Check MC memory logs
sqlite3 /home/ubuntu/mission-control/.data/mission-control.db "SELECT COUNT(*) FROM memory_logs;"
```

## Integration Summary

### System Flow

```
User Request
    ↓
Mission Control (Orchestration)
    ↓
OpenClaw Gateway (Routing)
    ↓
Agent (Execution) ↔ Memory (Context)
    ↓
Hermes (Alternative/Complementary)
    ↓
Result → Memory → Dashboard
```

### Memory Access Points

1. **OpenClaw Agent**: `memory_search(query)`, direct file reads
2. **Hermes Agent**: Utterance check via semantic search
3. **Mission Control**: `/api/memory/search`, Memory panel
4. **Shared Bridge**: `/home/ubuntu/sync-memory.sh`

## Quick Reference

### Start Services

```bash
# Mission Control
cd /home/ubuntu/mission-control && pnpm start

# OpenClaw Gateway
openclaw gateway start

# Memory Sync (runs via cron)
/home/ubuntu/sync-memory.sh
```

### Check Status

```bash
# Mission Control
curl -H "x-api-key: $MC_API_KEY" "$MC_URL/api/status"

# Gateway
curl -s http://127.0.0.1:18789/status

# Memory
ls /home/ubuntu/.openclaw/memory/
ls /home/ubuntu/shared-memory/
```

### Manage Agents

```bash
export MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
export MC_URL="http://localhost:3000"

cd /home/ubuntu/mission-control

# List agents
pnpm mc agents list

# Get agent details
pnpm mc agents get --agent-id <id>

# Wake agent
pnpm mc agents wake --agent-id <id> --message "Agent message"

# Agent memory
pnpm mc agents memory --agent-id <id> --action get
```

---

**Last Updated:** 2026-04-30 11:57 UTC
**Gateway Token:** `0c7e5ffce8ce20c417a37acfe020ae1cc0dbfe5bda7d3c33`
**API Key:** `ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a`
