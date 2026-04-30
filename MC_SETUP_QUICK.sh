#!/bin/bash
# Mission Control - Complete Hermès System Setup

MC_API_KEY="ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a"
MC_URL="http://localhost:3000"

echo "╔══════════════════════════════════════════════════════════╗"
echo "║   MISSION CONTROL — HERMES SYSTEM QUICK SETUP           ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# ═════════════════════════════════════════════════════════════
# PART 1: Register All Agents
# ═════════════════════════════════════════════════════════════
echo "registering agents..."

# Orchestrator
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "name":"orchestrator","role":"coordinator","soul_content":"Hermes Content Orchestrator - Master loop. 6-phase pipeline.","status":"idle"
}' "$MC_URL/api/agents" > /dev/null && echo "  ✓ orchestrator"

# Competitor Hunter
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "name":"competitor-hunter","role":"research","soul_content":"Find high-punch competitor posts.","status":"idle"
}' "$MC_URL/api/agents" > /dev/null && echo "  ✓ competitor-hunter"

# Insight Analyzer
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "name":"insight-analyzer","role":"analysis","soul_content":"Root cause analysis, brand filtering.","status":"idle"
}' "$MC_URL/api/agents" > /dev/null && echo "  ✓ insight-analyzer"

# Script Generator
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "name":"script-generator","role":"content","soul_content":"6-part scripts, max 80 words.","status":"idle"
}' "$MC_URL/api/agents" > /dev/null && echo "  ✓ script-generator"

# Content Queue
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "name":"content-queue","role":"coordination","soul_content":"Stage scripts in Notion, notify Telegram.","status":"idle"
}' "$MC_URL/api/agents" > /dev/null && echo "  ✓ content-queue"

# Memory Archivist
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "name":"memory-archivist","role":"system","soul_content":"Manage OpenClaw memory system.","status":"idle"
}' "$MC_URL/api/agents" > /dev/null && echo "  ✓ memory-archivist"

echo ""
echo "all agents registered"
echo ""

# ═════════════════════════════════════════════════════════════
# PART 2: Create Pipeline Tasks
# ═════════════════════════════════════════════════════════════
echo "creating pipeline tasks..."

# Phase 1: Competitor Hunter
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "title":"PHASE 1 - Competitor Hunter","description":"Find high-punch posts. Punch score > 3x, < 48h, > 50K views.","status":"inbox","priority":"high","assigned_to":"competitor-hunter","tags":["hermes","phase1","hunt"]
}' "$MC_URL/api/tasks" > /dev/null && echo "  ✓ phase 1: competitor hunter"

# Phase 2: Insight Analyzer
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "title":"PHASE 2 - Insight Analyzer","description":"Analyze hook types, story structure, root causes. Apply brand filters.","status":"inbox","priority":"high","assigned_to":"insight-analyzer","tags":["hermes","phase2","analyze","filter"]
}' "$MC_URL/api/tasks" > /dev/null && echo "  ✓ phase 2: insight analyzer"

# Phase 3: Script Generator
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "title":"PHASE 3 - Script Generator","description":"Generate 6-part scripts, 3 hooks, B-roll shots, VO notes. Max 80 words.","status":"inbox","priority":"high","assigned_to":"script-generator","tags":["hermes","phase3","create"]
}' "$MC_URL/api/tasks" > /dev/null && echo "  ✓ phase 3: script generator"

# Phase 4: Content Queue
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "title":"PHASE 4 - Content Queue","description":"Stage in Notion, send Telegram notification. Auto-assign slots.","status":"inbox","priority":"medium","assigned_to":"content-queue","tags":["hermes","phase4","queue"]
}' "$MC_URL/api/tasks" > /dev/null && echo "  ✓ phase 4: content queue"

# Phase 5: Memory Archivist
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "title":"PHASE 5 - Memory Sync","description":"Sync OpenClaw, Hermes, Mission Control memory.","status":"inbox","priority":"medium","assigned_to":"memory-archivist","tags":["hermes","phase5","sync","memory"]
}' "$MC_URL/api/tasks" > /dev/null && echo "  ✓ phase 5: memory sync"

# Daily Pipeline
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "title":"DAILY PIPELINE - 6AM IST","description":"Run full 6-phase Hermès autonomous content intelligence pipeline.","status":"assigned","priority":"high","assigned_to":"orchestrator","tags":["pipeline","hermes","daily","scheduled"]
}' "$MC_URL/api/tasks" > /dev/null && echo "  ✓ daily pipeline (6am ist)"

# Weekly Synthesis
curl -s -X POST -H "x-api-key: $MC_API_KEY" -H "Content-Type: application/json" -d '{
  "title":"WEEKLY SYNTHESIS - Sunday 8PM IST","description":"Analyze performance, rewrite SKILL files, compound intelligence.","status":"assigned","priority":"medium","assigned_to":"orchestrator","tags":["pipeline","hermes","weekly","synthesis"]
}' "$MC_URL/api/tasks" > /dev/null && echo "  ✓ weekly synthesis (sunday 8pm ist)"

echo ""
echo "all pipeline tasks created"
echo ""

# ═════════════════════════════════════════════════════════════
# Part 3: Summary
# ═════════════════════════════════════════════════════════════
echo "╔══════════════════════════════════════════════════════════╗"
echo "║            SYSTEM READY                                   ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "open mission control: http://localhost:3000"
echo ""
echo "what to see:"
echo "  - agents panel: 6 active hermes agents"
echo "  - tasks panel: 7 pipeline tasks ready"
echo "  - click any task → view → dispatch to agent"
echo ""
echo "what works:"
echo "  - openclaw gateway: running on port 18789"
echo "  - mission control: running on port 3000"
echo "  - hermes orchestrator: 6-phase pipeline automated"
echo "  - zapier mcp: connected for integrations"
echo "  - memory sync: every 5 minutes"
echo ""
echo "next:"
echo "  - open http://localhost:3000"
echo "  - go to agents panel → click orchestrator → wake → dispatch daily pipeline"
echo "  - watch tasks execute in real-time!"
echo ""
