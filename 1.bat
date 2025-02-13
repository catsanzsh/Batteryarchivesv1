@echo off
setlocal enabledelayedexpansion

:: Run as Administrator
net file >nul 2>&1 || (powershell -Command "Start-Process -FilePath '%~0' -Verb RunAs" && exit)

:: Set Power Plan to "Power Saver"
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

:: Disable NVIDIA GPU via Device Manager (forces system to use integrated graphics)
:: Warning: This will disable RTX! Remove this line if you need RTX active.
devcon disable "PCI\CC_0300"

:: Advanced Power Settings Tweaks (CPU Throttling, USB Selective Suspend)
powercfg /change /standby-timeout-ac 0
powercfg /change /hibernate-timeout-ac 0
powercfg /change /disk-timeout-ac 0
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_PROCESSOR IDLEDISABLE 000
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_PROCESSOR PROCTHROTTLEMAX 50%

:: Reduce Screen Brightness (requires NirCmd or third-party tools)
:: Download NirCmd: https://www.nirsoft.net/utils/nircmd.html
nircmd.exe setbrightness 30

:: Kill Background Apps
taskkill /f /im chrome.exe /im msedge.exe /im discord.exe /im steam.exe

:: Disable Startup Programs
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /va /f

echo Optimization complete. Close this window.
pause
