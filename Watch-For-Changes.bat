@echo off
REM Obsidian Git Watch - Continuous Sync
REM Double-click to auto-sync every 10 seconds while editing

chcp 65001 >nul
title Obsidian Git Watch

echo.
echo ========================================
echo   Obsidian Git Watch
echo ========================================
echo.
echo This will watch for changes and auto-sync every 10 seconds
echo Press Ctrl+C to stop
echo.
pause

powershell -ExecutionPolicy Bypass -File "%~dp0windows-obsidian-git-sync.ps1" -Action Watch
