# Tier-1 Laptop Windows 11 Debloater

A lightweight, hardware-safe Windows 11 debloating and optimization script specifically designed for laptops. Strips bloatware and telemetry while protecting OEM hardware controls, battery health, and SSD lifespan.

## Features

### Smart Debloating
- Removes Microsoft bloatware (Cortana, Xbox apps, Bing apps, etc.)
- Removes third-party trialware (McAfee, Norton, Spotify, etc.)
- **Preserves OEM apps** (MyASUS, Lenovo Vantage, Dell Power Manager) for battery and thermal control

### Privacy & Security
- Disables Windows telemetry and tracking
- Blocks lockscreen ads and Windows Spotlight
- Disables advertising ID and content delivery manager
- Removes diagnostic tracking services

### Performance Optimization
- Optimizes services for low RAM/CPU usage
- Disables Windows Search indexing (reduces SSD writes)
- Disables SysMain/Superfetch
- Tunes network stack for lower ping
- Enables Game Mode and Hardware-Accelerated GPU Scheduling

### UI Enhancements
- Restores classic Windows 10 context menu
- Hides search highlights and Cortana button
- Shows file extensions and hidden files by default
- Disables Start Menu recommendations

### Laptop Hardware Protection
- Disables Fast Startup and Hibernation (protects SSD)
- Forces Balanced power plan (prevents thermal throttling)
- Disables USB selective suspend (prevents disconnects)
- Optimized for battery life and thermals

## Requirements

- Windows 11
- Administrator privileges
- Internet connection (for initial script download)

## Installation

### Option 1: Download Release (Recommended)
1. Download the latest release from the [Releases](https://github.com/YOUR_USERNAME/LaptopDebloat/releases) page
2. Extract the ZIP file
3. Double-click `Run.bat`
4. Click "Yes" on the UAC prompt
5. Follow the on-screen instructions
6. Restart your PC when finished

### Option 2: Run from PowerShell
1. Right-click Start button and select "Terminal (Admin)" or "PowerShell (Admin)"
2. Paste the following command:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/YOUR_USERNAME/LaptopDebloat/main/Debloat.ps1'))
