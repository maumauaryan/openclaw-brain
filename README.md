# OpenClaw Brain — Obsidian-Style Knowledge Graph

Workspace brain files now live here with wikilink connections.

## Current Structure

```
brain/
├── SOUL.md          → Who the agent is
├── IDENTITY.md      → Name, emoji, creature
├── USER.md          → About Aryan
├── AGENTS.md        → Operating rules
├── MEMORY.md        → Long-term curated memory
├── HEARTBEAT.md     → Automated check schedule
└── skills/          → Specialized procedures
    ├── lead-researcher/
    ├── dm-drafter/
    └── hook-generator/
```

## Wikilink System

Every file uses `[[filename]]` syntax — Obsidian graph view shows these as connected nodes.

Example: HEARTBEAT.md references `[[MEMORY]]`, `[[SOUL]]`, `[[AGENTS]]` → this creates visible connections in graph view.

## Next-Level Features (Ready to Enable)

1. **Daily logs**: `memory/YYYY-MM-DD.md` linked to `[[MEMORY]]`
2. **Lead tracking**: `brain/leads/active.md` with each lead as `[[lead-name]]`
3. **Content library**: `brain/content/hooks.md`, `brain/content/ideas.md`
4. **Pattern learning**: Auto-update `[[dm-drafter]]` when DMs perform well

## For Graph View

Open this directory in Obsidian to see the live node graph:
- Settings → Core plugins → Graph view → Enable
- All wikilinks appear as connected nodes
- MDM files link to skills → skills link to procedures → everything visible

## Auto-Sync Strategy

- Heartbeat runs every 30m → updates `memory/YYYY-MM-DD.md`
- Skills self-update when patterns emerge
- Graph view refreshes automatically as files change

---

This is the "next level" system: observe → adapt → remember → improve.
