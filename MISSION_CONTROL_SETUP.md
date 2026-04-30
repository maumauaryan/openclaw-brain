# Mission Control - Complete Automation Setup

## 1. Windows Git Sync Fix

**Run these commands in your Windows PowerShell:**

```powershell
cd D:\openclaw-brain

# 1. Stash local conflicts
git stash -u

# 2. Pull latest with new sync scripts
git pull origin master

# 3. Check for new files
ls *.bat *.ps1 | sort

# 4. Test the new sync
.\Sync-To-GitHub.bat
```

---

## 2. Zapier MCP — ✅ Configured and Connected

**Connection verified**: `npx mcporter list zapier` returns schema

**Next Step**: Configure Zapier apps via the configuration URL:
```bash
npx mcporter call zapier.get_configuration_url()
```

This will give you a URL to add apps (Slack, Telegram, Notion) and configure triggers.

---

## 3. Mission Control — Hermes Orchestrator Integration

### Agents to Create

**1. orchestrator-agent**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "orchestrator",
    "role": "coordinator",
    "soul": "Hermes Content Orchestrator -精通的内容智能导演。6阶段流水线：HUNT→INGEST→EXTRACT→FILTER→CREATE→QUEUE。每天6AM IST自动运行。参考HERMES_ORCHESTRATOR_SKILLS.md。使用memory_search读取技能定义并执行。"
  }' \
  "http://localhost:3000/api/agents/create"
```

**2. competitor-hunter**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "competitor-hunter",
    "role": "research",
    "soul": "Competitor Hunter - 挖掘超越权重的对手帖子。参考HERMES_ORCHESTRATOR_SKILLS.md中competitor-hunter/SKILL.md。目标池：@mattgray @alxberman @iamgeorgebryant @codyaskins @hormozi @chrisdo @nathanbarry @justinwelsh @contentcreatorpro @dakotalrobertson。选择标准：punch score > 3x，< 48小时发布，> 50K Views。输出传递给video-ingester。"
  }' \
  "http://localhost:3000/api/agents/create"
```

**3. script-generator**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "script-generator",
    "role": "content",
    "soul": "Script Generator - 生产就绪脚本生成器。参考HERMES_ORCHESTRATOR_SKILLS.md中script-generator/SKILL.md。6部分结构（最大80字）：HOOK→TENSION→STAKES→REFRAME→PROOF→CTA。生成3个hook变体，B-roll镜头表，VO备注。目标：Aryan的声音（冷静、精准、创始人对创始人）。无需承诺，最大12字/句。"
  }' \
  "http://localhost:3000/api/agents/create"
```

**4. insight-analyzer**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "insight-analyzer",
    "role": "analysis",
    "soul": "Insight Analyst - 根因分析。参考HERMES_ORCHESTRATOR_SKILLS.md中insight-extractor/SKILL.md和brand-filter/SKILL.md。4层分析：Hook解剖、故事结构映射、保留工程、根因识别。品牌规则：拒绝dot culture、假紧迫、bro能量。翻译为Aryan的声音。"
  }' \
  "http://localhost:3000/api/agents/create"
```

### Cron Jobs to Create

**1. Daily Content Pipeline - 6:00 AM IST**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Daily Content Pipeline",
    "description": "Execute full Hermes content intelligence pipeline: HUNT→INGEST→EXTRACT→FILTER→CREATE→QUEUE",
    "schedule": "every morning at 6am",
    "assigned_to": "orchestrator",
    "priority": "high",
    "timezone": "Asia/Kolkata"
  }' \
  "http://localhost:3000/api/cron"
```

**2. Weekly Synthesis - Sunday 8:00 PM IST**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Weekly Content Synthesis",
    "description": "Analyze weekly performance, rewrite SKILL files, compound intelligence",
    "schedule": "every Sunday at 8pm",
    "assigned_to": "orchestrator",
    "priority": "medium",
    "timezone": "Asia/Kolkata"
  }' \
  "http://localhost:3000/api/cron"
```

**3. Competitor Pool Expansion - Daily 9:00 AM IST**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Expand Competitor Pool",
    "description": "Search and add new high-punch accounts to competitor pool",
    "schedule": "every morning at 9am",
    "assigned_to": "competitor-hunter",
    "priority": "low",
    "timezone": "Asia/Kolkata"
  }' \
  "http://localhost:3000/api/cron"
```

**4. Memory Sync - Every 30 minutes**
```bash
curl -X POST \
  -H "x-api-key: ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Memory Sync",
    "description": "Sync MEMORY.md and memory/YYYY-MM-DD.md to Hermes and Mission Control",
    "schedule": "every 30 minutes",
    "priority": "medium"
  }' \
  "http://localhost:3000/api/cron"
```

---

## 4. Subagent Workflows

### Workflow: Content Pipeline Execution

```javascript
{
  "name": "Content Pipeline Workflow",
  "description": "Execute full 6-phase content intelligence pipeline",
  "steps": [
    {
      "agent": "competitor-hunter",
      "task": "Find 3-5 high-punch competitor posts",
      "output": "target_posts"
    },
    {
      "agent": "competitor-hunter", // Reuse or create video-transcriber
      "task": "Transcribe each target post",
      "input": "target_posts",
      "output": "transcripts"
    },
    {
      "agent": "insight-analyzer",
      "task": "Extract insights and filter for brand alignment",
      "input": "transcripts",
      "output": "valid_insights"
    },
    {
      "agent": "script-generator",
      "task": "Generate production-ready scripts",
      "input": "valid_insights",
      "output": "scripts"
    },
    {
      "agent": "content-queue", // To be created
      "task": "Stage in Notion and notify via Telegram",
      "input": "scripts"
    }
  ],
  "trigger": "daily at 6AM IST",
  "notification": {
    "success": "Telegram",
    "failure": "Slack"
  }
}
```

---

## 5. Zapier Integration Workflows

### Configuration Steps

1. Get Zapier configuration URL:
```bash
npx mcporter call zapier.get_configuration_url()
```

2. Open URL in browser

3. Configure apps:
- **Slack**: Channel for notifications
- **Telegram**: Bot for script queue alerts
- **Notion**: Database for Content Pipeline

4. Create Zapier Zaps:

**Zap 1: New Script → Slack**
```
Trigger: Webhook (from Mission Control /api/webhooks)
Action: Send message to Slack channel
Message: "🎬 New script queued: [title] - [hook]"
```

**Zap 2: New Script → Telegram**
```
Trigger: Webhook
Action: Send Telegram message
Message: The Telegram format from content-queue SKILL.md
```

**Zap 3: Approved Script → Google Calendar**
```
Trigger: Notion database update (status: APPROVED)
Action: Create Google Calendar event
Title: [Script title]
Time: Scheduled date/time slot
```

---

## 6. Memory Integration Points

All agents read/write from MEMORY.md via `memory_search()`:

```bash
# Before any processing
memory_search("Hermes orchestrator pipeline spec")
memory_search("competitor pool current state")

# After processing
# Add to memory/YYYY-MM-DD.md with format:
## [timestamp] [agent_name] completed
**Context**: [brief description]
**Analysis**: [key findings]
**Action**: [what was done]
---
```

---

## 7. Complete Setup Command

Run this ONE script to set up everything:

```bash
#!/bin/bash
# setup-mission-control-hermes.sh

set -e

MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
MC_URL="http://localhost:3000"

echo "=== Setting up Hermes Orchestrator in Mission Control ==="

# Create agents
agents=(
  '{"name":"orchestrator","role":"coordinator","soul":"Hermes Content Orchestrator - Master loop. 6-phase pipeline. Read HERMES_ORCHESTRATOR_SKILLS.md. Execute daily 6AM IST. No human input required."}'
  '{"name":"competitor-hunter","role":"research","soul":"Competitor Hunter. Find high-punch posts. Pool: @mattgray @alxberman @iamgeorgebryant @hormozi @chrisdo. Punch score > 3x. < 48h. > 50K views. Pass to video-ingester."}'
  '{"name":"script-generator","role":"content","soul":"Script Generator. 6-part structure. Max 80 words. 3 hooks. B-roll shots. VO notes. Aryan voice: calm, precise, founder-to-founder. No promises. Max 12 words/sentence."}'
  '{"name":"insight-analyzer","role":"analysis","soul":"Insight Analyst. Root cause analysis. 4 layers: hook, structure, retention, root cause. Brand rules: no hustle culture, no fake urgency, no bro energy. Translate to Aryan voice."}'
)

for agent in "${agents[@]}"; do
  echo "Creating agent: $(echo $agent | jq -r .name)"
  curl -s -X POST \
    -H "x-api-key: $MC_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$agent" \
    "$MC_URL/api/agents/create" > /dev/null
done

# Create cron jobs
cron_jobs=(
  '{"title":"Daily Content Pipeline","description":"Full 6-phase pipeline","schedule":"every morning at 6am","assigned_to":"orchestrator","priority":"high","timezone":"Asia/Kolkata"}'
  '{"title":"Weekly Synthesis","description":"Analyze performance, rewrite SKILL files","schedule":"every Sunday at 8pm","assigned_to":"orchestrator","priority":"medium","timezone":"Asia/Kolkata"}'
  '{"title":"Expand Competitor Pool","description":"Add new high-punch accounts","schedule":"every morning at 9am","assigned_to":"competitor-hunter","priority":"low","timezone":"Asia/Kolkata"}'
)

for job in "${cron_jobs[@]}"; do
  echo "Creating cron job: $(echo $job | jq -r .title)"
  curl -s -X POST \
    -H "x-api-key: $MC_API_KEY" \
    -H "Content-Type: application/json" \
    -d "$job" \
    "$MC_URL/api/cron" > /dev/null
done

echo "=== Setup Complete ==="
echo "Check: http://localhost:3000 (Agents panel, Cron panel)"
```

---

## 8. Quick Reference

### Check Status
```bash
# Mission Control
curl -H "x-api-key: $MC_API_KEY" "$MC_URL/api/status"

# Agents
curl -H "x-api-key: $MC_API_KEY" "$MC_URL/api/agents"

# Cron jobs
curl -H "x-api-key: $MC_API_KEY" "$MC_URL/api/cron"
```

### Manual Trigger
```bash
# Trigger daily pipeline
curl -X POST \
  -H "x-api-key: $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"agentId":"orchestrator","message":"Run daily content pipeline"}' \
  "$MC_URL/api/agents/wake"
```

### View Logs
```bash
# Mission Control logs
tail -f /tmp/mission-control.log

# Memory sync logs
tail -f /tmp/memory-sync.log

# Gateway logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

---

## 9. Everything Ready To Go

✅ **Hermes skill files** documented in HERMES_ORCHESTRATOR_SKILLS.md
✅ **Zapier MCP** configured and connected
✅ **Agent definitions** ready (4 agents to create)
✅ **Cron jobs** ready (4 scheduled tasks)
✅ **Workflows** designed
✅ **Memory integration** mapped
✅ **Setup script** prepared

**Next Action**: Run the setup script to create agents and cron jobs in Mission Control.
