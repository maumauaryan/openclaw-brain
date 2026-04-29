# Windows Auto-Pull Setup for Live obsidian Changes

## Files Created

1. **auto-pull.ps1** — PowerShell script to pull updates from GitHub
2. **setup-windows-schedule.bat** — Windows Task Scheduler setup

## Quick Setup (1 minute)

### Option A: System Tray App (Recommended)

1. Copy these files to `D:\openclaw-brain\`
2. Run `setup-windows-schedule.bat` as Administrator
3. Windows Task Scheduler now pulls every 5 minutes
4. Obsidian detects file changes automatically

### Option B: Run Manually

```powershell
cd D:\openclaw-brain
powershell -ExecutionPolicy Bypass -File auto-pull.ps1
```

## How It Works

1. OpenClaw writes to D drive → Git cron pushes to GitHub
2. Windows Task Scheduler pulls every 5 minutes via auto-pull.ps1
3. Obsidian sees file changes → Graph view updates instantly
4. Check logs: `D:\openclaw-brain\pull-log.txt`

## Verify It's Working

1. Wait 5 minutes after setup
2. Check `D:\openclaw-brain\pull-log.txt`
3. You should see timestamps like:
   ```
   2026-04-29 22:22:15 - Starting auto-pull check...
   2026-04-29 22:22:18 - Pulled changes from GitHub
   2026-04-29 22:22:18 - Auto-pull check complete
   ```

## Troubleshooting

### Permission Error
Run `setup-windows-schedule.bat` as Administrator (right-click → Run as admin)

### Task Not Running
Open Task Scheduler (`taskschd.msc`) and find "OpenClawBrainAutoPull"

### Obsidian Not Updating
1. Obsidian sometimes caches files
2. Close and reopen Obsidian
3. Or press `Ctrl+R` to refresh vault

## Remove Auto-Pull Later

```cmd
schtasks /delete /tn "OpenClawBrainAutoPull" /f
```

---

**Near-live updates. Every 5 minutes. Fully automated.**
