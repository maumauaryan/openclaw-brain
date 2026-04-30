# Obsidian Git Sync Script - Windows Version
# Automatically syncs local Obsidian vault to GitHub repository
# 
# Usage:
#   .\windows-obsidian-git-sync.ps1 -Sync
#   .\windows-obsidian-git-sync.ps1 -Watch
#   .\windows-obsidian-git-sync.ps1 -Status

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("Sync", "Watch", "Status", "Push", "Pull", "Log", "Help")]
    [string]$Action = "Sync",

    [Parameter(Mandatory=$false)]
    [string]$VaultPath = "C:\Users\Aryan\Documents\ObsidianVault",

    [Parameter(Mandatory=$false)]
    [string]$RepoPath = "C:\Users\Aryan\Documents\ObsidianVault",

    [Parameter(Mandatory=$false)]
    [switch]$NoPush,

    [Parameter(Mandatory=$false)]
    [switch]$NoPull,

    [Parameter(Mandatory=$false)]
    [ValidateSet("Theirs", "Ours", "Merge")]
    [string]$ConflictStrategy = "Theirs",

    [Parameter(Mandatory=$false)]
    [string]$CommitPrefix = "📝 Obsidian",

    [Parameter(Mandatory=$false)]
    [int]$WatchIntervalSeconds = 10
)

# ═══════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════

$script:LogPath = "$env:USERPROFILE\obsidian-git-sync.log"
$script:MaxFilesPerCommit = 50

# ═══════════════════════════════════════════════════════════════
# UTILITY FUNCTIONS
# ═══════════════════════════════════════════════════════════════

function Write-Log {
    param(
        [string]$Level,
        [string]$Message
    )

    $timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
    $logEntry = "[$timestamp] [$Level] $Message"
    
    Write-Host $logEntry
    Add-Content -Path $script:LogPath -Value $logEntry
}

function Test-GitInstalled {
    try {
        $null = git --version 2>&1
        return $true
    } catch {
        Write-Log "ERROR" "Git is not installed. Install from: https://git-scm.com/"
        return $false
    }
}

function Test-RepoExists {
    $gitDir = Join-Path $RepoPath ".git"
    return (Test-Path $gitDir)
}

function Get-Timestamp {
    return Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
}

# ═══════════════════════════════════════════════════════════════
# GIT OPERATIONS
# ═══════════════════════════════════════════════════════════════

function Invoke-GitPull {
    if (-not $NoPull) {
        Write-Log "INFO" "Pulling from remote..."

        # Set pull strategy to never rebase
        git -C $RepoPath config pull.rebase false 2>$null

        $result = git -C $RepoPath pull origin (git -C $RepoPath branch --show-current) 2>&1

        if ($LASTEXITCODE -eq 0) {
            Write-Log "INFO" "Pull completed successfully"
            return $true
        } else {
            Write-Log "WARN" "Pull failed or had conflicts"
            return $false
        }
    }
    return $true
}

function Resolve-Conflicts {
    $conflicts = git -C $RepoPath diff --name-only --diff-filter=U 2>$null

    if (-not [string]::IsNullOrWhiteSpace($conflicts)) {
        Write-Log "WARN" "Conflict detected in files:"
        $conflicts | ForEach-Object {
            Write-Log "WARN" "  - $_"
        }

        switch ($ConflictStrategy) {
            "Theirs" {
                Write-Log "INFO" "Using 'theirs' strategy (accepting incoming changes)"
                git -C $RepoPath checkout --theirs . 2>$null
                git -C $RepoPath add . 2>$null
            }
            "Ours" {
                Write-Log "INFO" "Using 'ours' strategy (keeping local changes)"
                git -C $RepoPath checkout --ours . 2>$null
                git -C $RepoPath add . 2>$null
            }
            "Merge" {
                Write-Log "INFO" "Leaving conflicts for manual resolution"
            }
            default {
                Write-Log "WARN" "Unknown conflict strategy: $ConflictStrategy"
            }
        }
    }
}

function Invoke-GitPush {
    if (-not $NoPush) {
        Write-Log "INFO" "Pushing to remote..."

        $result = git -C $RepoPath push origin (git -C $RepoPath branch --show-current) 2>&1

        if ($LASTEXITCODE -eq 0) {
            Write-Log "INFO" "Push completed successfully"
            return $true
        } else {
            Write-Log "ERROR" "Push failed"
            return $false
        }
    }
    return $true
}

function New-GitCommit {
    $status = git -C $RepoPath status --porcelain 2>$null

    if ([string]::IsNullOrWhiteSpace($status)) {
        Write-Log "INFO" "No changes to commit"
        return $false
    }

    $changedFiles = ($status | Measure-Object).Count
    Write-Log "INFO" "Changes detected: $changedFiles file(s)"

    if ($changedFiles -gt $script:MaxFilesPerCommit) {
        Write-Log "WARN" "Large change set ($changedFiles files). Consider reviewing before committing."
    }

    # Stage all changes
    Write-Log "INFO" "Staging changes..."
    $null = git -C $RepoPath add -A 2>&1

    # Create commit message
    $fileList = ($status | Select-Object -First 10 | ForEach-Object { "  - $_" }) -join "`n"
    
    $commitMsg = "$CommitPrefix sync - $(Get-Timestamp)`n$fileList"
    
    if ($changedFiles -gt 10) {
        $commitMsg += "`n  ... and $($changedFiles - 10) more files"
    }

    # Commit
    Write-Log "INFO" "Creating commit..."
    $result = git -C $RepoPath commit -m $commitMsg 2>&1

    if ($LASTEXITCODE -eq 0) {
        Write-Log "INFO" "Commit created successfully"
        return $true
    } else {
        Write-Log "ERROR" "Commit failed (no changes?)"
        return $false
    }
}

function Show-GitStatus {
    Write-Log "INFO" "=== Git Status ==="
    Write-Host ""

    $status = git -C $RepoPath status --short 2>&1
    $status | Write-Host

    Write-Host ""

    if ([string]::IsNullOrWhiteSpace($status)) {
        Write-Log "INFO" "Working tree clean (no changes)"
    } else {
        $modified = ($status | Select-String "^.M").Count
        $added = ($status | Select-String "^.M").Count
        $deleted = ($status | Select-String "^.D").Count
        $untracked = ($status | Select-String "^\?\?").Count

        Write-Log "INFO" "Changes: $modified modified, $added added, $deleted deleted, $untracked untracked"
    }
}

function Invoke-Sync {
    Write-Log "INFO" "Starting sync..."
    Write-Log "INFO" "Vault: $VaultPath"
    Write-Log "INFO" "Repo: $RepoPath"
    
    $remoteUrl = git -C $RepoPath config --get remote.origin.url 2>$null
    Write-Log "INFO" "Remote: $remoteUrl"

    # Pull first
    Invoke-GitPull | Out-Null

    # Show status
    Show-GitStatus

    # Commit if changes exist
    New-GitCommit | Out-Null

    # Resolve conflicts
    Resolve-Conflicts

    # Push
    Invoke-GitPush | Out-Null

    Write-Log "INFO" "=== Sync Complete ==="
    Write-Host ""
}

function Start-Watcher {
    Write-Log "INFO" "Starting file watcher..."
    Write-Log "INFO" "Press Ctrl+C to stop"
    Write-Log "INFO" "Check interval: $WatchIntervalSeconds seconds"

    while ($true) {
        Start-Sleep -Seconds $WatchIntervalSeconds
        Invoke-Sync
    }
}

# ═══════════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════════

function Show-Help {
    @"
Obsidian Git Sync Script - Windows Version

Automatically syncs local Obsidian vault to GitHub repository.

Usage:
    .\windows-obsidian-git-sync.ps1 -Action Sync
    .\windows-obsidian-git-sync.ps1 -Action Watch
    .\windows-obsidian-git-sync.ps1 -Action Status

Actions:
    Sync    Run a single sync (commit + pull + push)
    Watch   Watch for file changes and auto-sync (polls every 10s)
    Status  Show current git status
    Push    Push local commits to remote
    Pull    Pull changes from remote
    Log     Show sync log

Parameters:
    -VaultPath <path>
        Obsidian vault path (default: C:\Users\Aryan\Documents\ObsidianVault)
    
    -RepoPath <path>
        Git repository path (default: same as VaultPath)
    
    -NoPush
        Skip pushing to remote
    
    -NoPull
        Skip pulling from remote
    
    -ConflictStrategy <Theirs|Ours|Merge>
        Conflict resolution strategy (default: Theirs)
    
    -CommitPrefix <prefix>
        Commit message prefix (default: 📝 Obsidian)
    
    -WatchIntervalSeconds <seconds>
        Watcher polling interval (default: 10)

Examples:
    # Single sync
    .\windows-obsidian-git-sync.ps1 -Action Sync

    # Watch for changes
    .\windows-obsidian-git-sync.ps1 -Action Watch

    # Sync without pushing
    .\windows-obsidian-git-sync.ps1 -Action Sync -NoPush

    # Custom vault path
    .\windows-obsidian-git-sync.ps1 -Action Sync -VaultPath "C:\MyVault"

    # Use custom conflict strategy
    .\windows-obsidian-git-sync.ps1 -Action Sync -ConflictStrategy Ours

Setup Instructions:
1. Install Git: https://git-scm.com/
2. Clone your repo: git clone git@github.com:maumauaryan/openclaw-brain.git
3. Set vault path to your git repo folder
4. Run first sync: .\windows-obsidian-git-sync.ps1 -Action Sync

"@
}

# Validate Git installation
if (-not (Test-GitInstalled)) {
    Write-Host "Git not installed. Install from: https://git-scm.com/"
    exit 1
}

# Validate repository exists
if (-not (Test-RepoExists)) {
    Write-Log "ERROR" "Git repository not found at: $RepoPath"
    Write-Log "INFO" "Initialize with: git init $RepoPath"
    Write-Log "INFO" "Or clone: git clone git@github.com:maumauaryan/openclaw-brain.git $RepoPath"
    exit 1
}

# Execute action
switch ($Action) {
    "Sync" {
        Invoke-Sync
    }
    "Watch" {
        Start-Watcher
    }
    "Status" {
        Show-GitStatus
    }
    "Push" {
        Invoke-GitPush
    }
    "Pull" {
        Invoke-GitPull
    }
    "Log" {
        if (Test-Path $script:LogPath) {
            Get-Content $script:LogPath -Tail 50
        } else {
            Write-Host "No log file found: $script:LogPath"
        }
    }
    "Help" {
        Show-Help
    }
    default {
        Write-Log "ERROR" "Unknown action: $Action"
        Show-Help
        exit 1
    }
}
