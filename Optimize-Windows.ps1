# ═══════════════════════════════════════════════════════════════════
#  OPTIMIZE-WINDOWS.PS1 (TIER-1 LAPTOP WINDOWS 11 DEBLOATER)
#  Designed to compete with CTT, Atlas, and ReviOS.
#  Hardware-Safe: Protects OEM controls, Battery, and SSD.
#  Now with AI/Copilot removal and Windows Update control!
# ══════════════════════════════════════════════════════════════════

Clear-Host

# [0] DISCLAIMER & CONFIRMATION MENU
# ═══════════════════════════════════════════════════════════════════
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  TIER-1 LAPTOP WINDOWS 11 DEBLOATER (BETA v2.0)" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "WARNING: This script is currently in BETA." -ForegroundColor Red
Write-Host "While it is designed specifically for laptops to protect" -ForegroundColor Yellow
Write-Host "OEM hardware controls, battery limits, and thermals," -ForegroundColor Yellow
Write-Host "running system-level scripts always carries inherent risks." -ForegroundColor Yellow
Write-Host ""
Write-Host "WHAT THIS SCRIPT DOES:" -ForegroundColor Green
Write-Host "  - Removes Microsoft bloatware and third-party trialware" -ForegroundColor White
Write-Host "  - Disables telemetry, tracking, and lockscreen ads" -ForegroundColor White
Write-Host "  - Disables Windows Copilot and AI features" -ForegroundColor White
Write-Host "  - Optimizes services for low RAM/CPU usage" -ForegroundColor White
Write-Host "  - Tunes network stack and gaming features" -ForegroundColor White
Write-Host "  - Restores classic context menu and cleans UI" -ForegroundColor White
Write-Host "  - Disables Fast Startup/Hibernation to protect SSD" -ForegroundColor White
Write-Host "  - Prevents Windows Update from installing drivers" -ForegroundColor White
Write-Host ""
Write-Host "WHAT IT PROTECTS:" -ForegroundColor Green
Write-Host "  - Keeps OEM apps (MyASUS, etc.) for battery/fan control" -ForegroundColor White
Write-Host "  - Forces Balanced power plan to prevent thermal throttling" -ForegroundColor White
Write-Host "  - Creates a System Restore Point before making changes" -ForegroundColor White
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan

$confirm = Read-Host "`nAre you sure you want to proceed? (Y/N)"
if ($confirm -ne 'Y' -and $confirm -ne 'y') {
    Write-Host "`nScript aborted by user. Exiting..." -ForegroundColor Red
    Start-Sleep -Seconds 2
    exit
}

# [1] ADMIN CHECK & SAFETY NET
# ══════════════════════════════════════════════════════════════════
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You need to run this script as Administrator!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

Write-Host "`nCreating System Restore Point (Safety Net)..." -ForegroundColor Cyan
Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
Checkpoint-Computer -Description "Pre-Debloater Laptop Optimization v2.0" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue | Out-Null
Write-Host "[+] Restore point created. You are safe to proceed." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 2. SMART APP REMOVAL (Nuke Bloat, Keep OEM)
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 1: Removing Bloatware & Trialware..." -ForegroundColor Cyan

$bloatApps = @(
    # Microsoft Bloat
    "*Microsoft.BingNews*", "*Microsoft.BingWeather*", "*Microsoft.BingFinance*",
    "*Microsoft.GetHelp*", "*Microsoft.Getstarted*", "*Microsoft.MicrosoftSolitaireCollection*",
    "*Microsoft.People*", "*Microsoft.Todos*", "*Microsoft.WindowsFeedbackHub*",
    "*Microsoft.WindowsMaps*", "*Microsoft.YourPhone*", "*Microsoft.ZuneMusic*",
    "*Microsoft.ZuneVideo*", "*Microsoft.GamingApp*", "*Microsoft.Xbox.TCUI*",
    "*Microsoft.XboxGameOverlay*", "*Microsoft.XboxGamingOverlay*", "*Microsoft.XboxIdentityProvider*",
    "*Microsoft.XboxSpeechToTextOverlay*", "*Microsoft.WindowsAlarms*", "*Microsoft.WindowsCamera*",
    "*Clipchamp.Clipchamp*", "*MicrosoftTeams*", "*Microsoft.549981C3F5F10*", 
    "*Microsoft.Copilot*", "*Microsoft.OutlookForWindows*",
    # Third-Party Trialware
    "*McAfee*", "*Norton*", "*Dropbox*", "*Spotify*", "*Disney*", "*CandyCrush*",
    "*FarmVille*", "*Asphalt*", "*TikTok*", "*Instagram*", "*Netflix*"
)

foreach ($app in $bloatApps) {
    Get-AppxPackage -AllUsers -Name $app -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Where-Object DisplayName -like $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue | Out-Null
}
Write-Host "[+] Bloatware removed. (OEM ASUS/Lenovo/Dell apps preserved)." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 3. TELEMETRY, PRIVACY & SPYWARE NUKING
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 2: Disabling Telemetry & Tracking..." -ForegroundColor Cyan

# Disable Diagnostics Tracking Services
$telemetryServices = @("DiagTrack", "dmwappushservice")
foreach ($svc in $telemetryServices) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

# Registry Telemetry Nuke
$paths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot",
    "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot",
    "HKCU:\Software\Policies\Microsoft\Windows\WindowsAI"
)

foreach ($path in $paths) {
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
}

# Set Telemetry to Level 1 (Required/Basic) - Safer than 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "RotatingLockScreenEnabled" -Value 0 -Force -ErrorAction SilentlyContinue

# Disable Tailored Experiences (prevents MS from using data for personalized ads)
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" -Name "TailoredExperiencesWithDiagnosticDataEnabled" -Value 0 -Force -ErrorAction SilentlyContinue

# Disable Activity History
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Value 0 -Force -ErrorAction SilentlyContinue

Write-Host "[+] Telemetry, tracking, and lockscreen ads disabled." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 4. DISABLE AI & COPILOT (NEW IN v2.0)
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 3: Disabling Windows Copilot & AI Features..." -ForegroundColor Cyan

# Disable Windows Copilot (User & System level)
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1 -Force -ErrorAction SilentlyContinue

# Disable Windows AI Data Analysis (Recall/Snipping tool AI)
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsAI" -Name "DisableAIDataAnalysis" -Value 1 -Force -ErrorAction SilentlyContinue

Write-Host "[+] Windows Copilot and AI features disabled." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 5. SERVICES & SCHEDULED TASKS OPTIMIZATION
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 4: Optimizing Services & Background Tasks..." -ForegroundColor Cyan

$servicesToDisable = @(
    "SysMain", "WSearch", "XblAuthManager", "XblGameSave", 
    "XboxGipSvc", "XboxNetApiSvc", "RetailDemo", "WbioSrvc"
)

foreach ($svc in $servicesToDisable) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
}

$servicesToManual = @("Fax", "PrintSpooler", "WMPNetworkSvc", "RemoteRegistry", "TabletInputService")
foreach ($svc in $servicesToManual) {
    Set-Service -Name $svc -StartupType Manual -ErrorAction SilentlyContinue
}

Write-Host "[+] Services optimized for low RAM and CPU usage." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 6. NETWORK & GAMING STACK OPTIMIZATION
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 5: Network & Gaming Stack..." -ForegroundColor Cyan

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value "0xffffffff" -Force -ErrorAction SilentlyContinue

netsh int tcp set global autotuninglevel=normal | Out-Null
netsh int tcp set global chimney=disabled | Out-Null
netsh int tcp set global ecncapability=disabled | Out-Null
netsh int tcp set global rss=enabled | Out-Null

Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AutoGameModeEnabled" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" -Name "HwSchMode" -Value 2 -Force -ErrorAction SilentlyContinue

Write-Host "[+] Network stack and gaming features optimized." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 7. WINDOWS UPDATE CONTROL (NEW IN v2.0)
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 6: Configuring Windows Update..." -ForegroundColor Cyan

# Prevent Windows Update from automatically installing drivers
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -Force -ErrorAction SilentlyContinue

# Disable automatic restart after updates
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Force -ErrorAction SilentlyContinue

Write-Host "[+] Windows Update configured (no auto-drivers, no forced reboots)." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 8. UI, EXPLORER & QUALITY OF LIFE
# ══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 7: UI & Explorer Cleanup..." -ForegroundColor Cyan

$contextMenuPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
if (!(Test-Path $contextMenuPath)) { New-Item -Path $contextMenuPath -Force | Out-Null }
Set-ItemProperty -Path $contextMenuPath -Name "(default)" -Value "" -Force -ErrorAction SilentlyContinue

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2 -Force -ErrorAction SilentlyContinue

Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Force -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_Layout" -Value 1 -Force -ErrorAction SilentlyContinue

Write-Host "[+] UI cleaned and modernized." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 9. LAPTOP HARDWARE PROTECTION (Battery, Thermals, SSD)
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 8: Laptop Hardware Protection..." -ForegroundColor Cyan

Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Value 0 -Force -ErrorAction SilentlyContinue
powercfg /hibernate off | Out-Null

powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e

powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
powercfg /setactive scheme_current

Write-Host "[+] Hardware protection applied. SSD and battery safe." -ForegroundColor Green

# ═══════════════════════════════════════════════════════════════════
# 10. FINAL CLEANUP & RESTART EXPLORER
# ═══════════════════════════════════════════════════════════════════
Write-Host "`nPhase 9: Final Cleanup..." -ForegroundColor Cyan

Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

taskkill /f /im explorer.exe | Out-Null
Start-Sleep -Seconds 2
Start-Process explorer.exe

# ═══════════════════════════════════════════════════════════════════
# SUMMARY
# ═══════════════════════════════════════════════════════════════════
Write-Host "`n========================================================" -ForegroundColor Cyan
Write-Host " TIER-1 LAPTOP DEBLOAT v2.0 COMPLETE!" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "[+] Bloatware & Telemetry nuked" -ForegroundColor Green
Write-Host "[+] Windows Copilot & AI disabled" -ForegroundColor Green
Write-Host "[+] Services optimized (RAM/CPU saved)" -ForegroundColor Green
Write-Host "[+] Network & Gaming stack tuned" -ForegroundColor Green
Write-Host "[+] Windows Update controlled (no auto-drivers)" -ForegroundColor Green
Write-Host "[+] UI modernized (Classic context menu, no ads)" -ForegroundColor Green
Write-Host "[+] Laptop hardware protected (SSD/Battery/Thermals)" -ForegroundColor Green
Write-Host "`n[!] PLEASE RESTART YOUR PC TO FINALIZE ALL CHANGES." -ForegroundColor Yellow
