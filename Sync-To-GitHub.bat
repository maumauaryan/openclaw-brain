@echo off
REM Obsidian Git Sync - Quick Launcher
REM Double-click this to sync your Obsidian vault to GitHub

chcp 65001 >nul
title Obsidian Git Sync

echo.
echo ========================================
echo   Obsidian Git Sync
echo ========================================
echo.

REM Check for PowerShell
where powershell >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: PowerShell not found
    pause
    exit /b 1
)

REM Run the PowerShell script
powershell -ExecutionPolicy Bypass -File "%~dp0windows-obsidian-git-sync.ps1" -Action Sync

echo.
echo ========================================
echo   Sync Complete!
echo ========================================
echo.
pause
