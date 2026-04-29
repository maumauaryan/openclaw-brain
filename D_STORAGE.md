# D Drive Storage Configuration

## Why D Drive

- More storage capacity for long-term memory collection
- Windows filesystem accessible from both Linux OpenClaw and local Windows
- Reduces pressure on server root filesystem
- Single source of truth for all brain files

## Architecture

```
/mnt/d/openclaw-brain/brain/        ← D drive (Windows D:\openclaw-brain\brain\)
       ↓
symlink: /home/ubuntu/.openclaw/workspace/brain
       ↓
OpenClaw sees same structure → Continuous operation
       ↓
sync.sh → GitHub push Auto every 10 min
```

## Path Resolution

**From OpenClaw:** `/home/ubuntu/.openclaw/workspace/brain/*`
**Actual file location:** `/mnt/d/openclaw-brain/brain/*`
**From Windows:** `D:\openclaw-brain\brain\*`

## Directory Structure on D Drive

```
D:\openclaw-brain\
├── brain\
│   ├── INDEX.md
│   ├── SOUL.md, IDENTITY.md, USER.md, MEMORY.md
│   ├── AGENTS.md, HEARTBEAT.md, AUTO_MEMORY.md
│   ├── memory/
│   │   ├── 2026-04-29.md  ← Daily logs
│   │   └── 2026-W17.csv   ← Weekly stats
│   ├── content/
│   │   ├── hooks.md
│   │   ├── ideas.md
│   │   └── b-roll.md
│   ├── leads/
│   │   ├── active.md
│   │   ├── researched.md
│   │   └── replied.md
│   └── skills/
│       ├── lead-researcher/SKILL.md
│       ├── dm-drafter/SKILL.md
│       └── hook-generator/SKILL.md
└── .git/  ← Repo initialized here
```

## Automated Sync

- **OB sync:** Every 10 minutes via cron
- **Trigger:** `/home/ubuntu/.openclaw/workspace/brain/sync.sh`
- **Target:** `git@github.com:maumauaryan/openclaw-brain.git`
- **Logs:** `journalctl -f -t openclaw-brain-sync`

## Access Methods

**From Windows:** Direct file access to `D:\openclaw-brain\brain\*`
**From OpenClaw:** Via symlink at `/home/ubuntu/.openclaw/workspace/brain`
**GitHub:** https://github.com/maumauaryan/openclaw-brain
**Obsidian:** Clone repo → Open folder → Graph view

**Single storage point. Multiple access paths. Continuous sync.**

---

Linked: [[INDEX]] | [[SETUP]] | [[SYNC_COMPLETE]]
