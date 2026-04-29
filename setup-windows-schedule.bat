@echo off
REM Setup Windows Task Scheduler for auto-pull every 5 minutes
REM Run this as Administrator

set SCRIPT_PATH=D:\openclaw-brain\auto-pull.ps1
set TASK_NAME=OpenClawBrainAutoPull

echo Creating Windows Task Scheduler job...

schtasks /create /tn "%TASK_NAME%" /tr "powershell.exe -ExecutionPolicy Bypass -File '%SCRIPT_PATH%'" /sc minute /mo 5 /f

if %ERRORLEVEL% EQU 0 (
    echo Success! Auto-pull scheduled every 5 minutes.
    echo.
    echo To view scheduled tasks:
    echo   taskschd.msc
    echo.
    echo To remove this task later:
    echo   schtasks /delete /tn "%TASK_NAME%" /f
) else (
    echo ERROR: Failed to create scheduled task.
    echo Make sure you're running as Administrator.
)

pause
