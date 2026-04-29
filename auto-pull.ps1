# OpenClaw Brain Auto-Pull Script for Windows
# Place this in D:\openclaw-brain\
# Run it or schedule it via Windows Task Scheduler

# Configuration
$RepoPath = "D:\openclaw-brain"
$LogFile = "D:\openclaw-brain\pull-log.txt"

# Function to log with timestamp
function Log-Message {
    param([string]$message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $message" | Out-File -FilePath $LogFile -Append -Encoding UTF8
    Write-Host "$timestamp - $message"
}

# Change to repo directory
Set-Location $RepoPath

Log-Message "Starting auto-pull check..."

# Check if we're in a git repo
if (-not (Test-Path ".git")) {
    Log-Message "ERROR: Not in a git repository!"
    exit 1
}

# Stash any local changes first (safety)
git stash push -m "Auto-stash before pull $(Get-Date -Format 'yyyy-MM-dd HH:mm')" 2>&1 | Out-Null

# Pull latest changes
$pullResult = git pull origin master 2>&1

if ($LASTEXITCODE -eq 0) {
    if ($pullResult -match "Already up to date") {
        Log-Message "No changes detected"
    } else {
        Log-Message "Pulled changes from GitHub"
        Log-Message "$pullResult"
    }
} else {
    Log-Message "ERROR: Git pull failed!"
    Log-Message "$pullResult"
}

# Restore possible stashed changes (optional - comment out if not needed)
git stash pop 2>&1 | Out-Null

Log-Message "Auto-pull check complete"
Log-Message "---"
