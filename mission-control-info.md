# Mission Control Setup - COMPLETE

## Installation Complete ✓

Mission Control is installed and running.

## Access

- **Mission Control Dashboard**: http://localhost:3000
- **OpenClaw Gateway**: http://127.0.0.1:18789
- **Initial Setup**: Visit http://localhost:3000/setup to create your admin account

## Credentials

API Key: `ebb89775d08bb0c88af07165a70a91c4c60bfad40a88f25f8f756c82dcef938a`

## Starting Services

### Mission Control Terminal (currently running)
```bash
cd /home/ubuntu/mission-control
pnpm start
```

### OpenClaw Gateway
```bash
openclaw gateway start
# Check status: openclaw gateway status
# Stop: openclaw gateway stop
```

### Quick Launcher Script
```bash
/home/ubuntu/start-mission-control.sh
```

## Architecture

```
┌─────────────────────────────────────────┐
│  Mission Control Dashboard (Next.js)    │
│  http://localhost:3000                  │
│  - 32 control panels                    │
│  - Real-time updates (WebSocket/SSE)    │
│  - Multi-agent orchestration            │
└──────────────┬──────────────────────────┘
               │
               │ HTTP/WebSocket
               │
┌──────────────▼──────────────────────────┐
│  OpenClaw Gateway                       │
│  http://127.0.0.1:18789                 │
│  - Agent runtime management             │
│  - Session routing                      │
│  - Tool orchestration                   │
└──────────────┬──────────────────────────┘
               │
               │ CLI / API
               │
┌──────────────▼──────────────────────────┐
│  OpenClaw Workspace                     │
│  /home/ubuntu/.openclaw                 │
│  - Skills, agents, memory, cron         │
└─────────────────────────────────────────┘
```

## Features Available

### 32 Control Panels
- **Tasks & Projects**: Kanban workflow, multi-project support
- **Agents**: Lifecycle management, heartbeat monitoring, SOUL personalities
- **Skills Hub**: Install from ClawdHub, security-scanned
- **Memory**: Browser, search, graph visualization
- **Sessions**: Live transcript view, cross-session messaging
- **Cron**: Job scheduler, wake events
- **Logs**: Unified activity stream, grep search
- **Tokens**: Cost tracking, per-model breakdowns
- **Security**: Trust scoring, secret detection, MCP auditing
- **Webhooks**: External integrations
- **Alerts**: Configurable notifications
- **Pipelines**: Workflow automation

### Integration Points
- **OpenClaw Gateway**: Full integration
- **Claude Code**: Read-only bridge to sessions
- **CrewAI, LangGraph, AutoGen**: Framework adapters
- **CLI Tools**: Direct integration support

## API Access

```bash
export MC_URL="http://localhost:3000"
export MC_API_KEY="ebb89775d08bb0c88af07265a70a91c4c60bfad40a88f25f8f756c82dcef938a"

# List agents
curl -H "Authorization: Bearer $MC_API_KEY" "$MC_URL/api/agents"

# Create a task
curl -X POST "$MC_URL/api/tasks" \
  -H "Authorization: Bearer $MC_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"title":"Research competitors","priority":1}'

# Check gateway health
curl -H "Authorization: Bearer $MC_API_KEY" "$MC_URL/api/gateways/health"
```

## Environment Configuration

### Mission Control (.env)
- `OPENCLAW_HOME=/home/ubuntu/.openclaw`
- `OPENCLAW_GATEWAY_HOST=127.0.0.1`
- `OPENCLAW_GATEWAY_PORT=18789`
- `NEXT_PUBLIC_GATEWAY_PORT=18789`

### Working Directories
- Mission Control: `/home/ubuntu/mission-control`
- OpenClaw Workspace: `/home/ubuntu/.openclaw`
- Documentation: `/home/ubuntu/.openclaw/workspace/mission-control-info.md`

## Troubleshooting

### Mission Control not responding
```bash
cd /home/ubuntu/mission-control
# Check if running
ps aux | grep "next start"
# Restart
pkill -f "next start"
pnpm start
```

### Gateway connection issues
```bash
openclaw gateway status
openclaw gateway restart
# Check logs
tail -f /tmp/openclaw/openclaw-$(date +%Y-%m-%d).log
```

### View logs in dashboard
Navigate to: Panels → Activity Stream → All Events

## Next Steps

1. **Create Admin Account**: Visit http://localhost:3000/setup
2. **Connect OpenClaw Gateway**: Should auto-connect at http://127.0.0.1:18789
3. **Explore Panels**: Browse the 32 available control panels
4. **Create First Agent**: Agents → Register Agent
5. **Schedule Your First Task**: Tasks → Create Task

## Documentation

- **Quick Start**: https://github.com/builderz-labs/mission-control/blob/main/docs/quickstart.md
- **Agent Setup**: https://github.com/builderz-labs/mission-control/blob/main/docs/agent-setup.md
- **Orchestration**: https://github.com/builderz-labs/mission-control/blob/main/docs/orchestration.md
- **API Reference**: http://localhost:3000/api-docs
- **Repository**: https://github.com/builderz-labs/mission-control

## System Status

- ✓ Mission Control: Running on port 3000
- ✓ OpenClaw Gateway: Running on port 18789
- ✓ Dependencies: Installed (pnpm + 1041 packages)
- ✓ Build: Complete (production build ready)
- ✓ Integration: OpenClaw connected

---

_Last updated: 2026-04-30 10:23 UTC_
