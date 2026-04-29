# HEARTBEAT.md — Automated Checks

Keep this file empty (baseline). Add tasks below when you want periodic checks.

---

## Current Config

- **Mode:** Manual trigger only
- **Status:** HEARTBEAT_OK when nothing needs attention

## When to Activate Heartbeats

Use the `cron` tool to schedule automated heartbeats. Example plans:

### Daily Morning Briefing (7:00 AM IST)
```bash
# Read [[MEMORY]] → surface pending
# Check Discord/Telegram → urgent messages
# Send: "Today's priorities: [1], [2], [3]. One thing: [X]"
```

### Every 30 Minutes (9:00 AM - 6:00 PM IST)
```bash
# Quick scan: urgent DMs?
# If reply detected → alert with context + draft
# If nothing → HEARTBEAT_OK (silent)
```

### End of Day Review (9:00 PM IST)
```bash
# Log: what got done, what skipped, key learnings
# Update [[MEMORY]] with daily summary
# Set tomorrow's #1 priority
```

---

Linked: [[SOUL]] | [[IDENTITY]] | [[MEMORY]] | [[AGENTS]]
