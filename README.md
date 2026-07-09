# Tier-1 Laptop Windows 11 Debloater

A lightweight, hardware-safe Windows 11 debloating and optimization script specifically designed for laptops. Strips bloatware and telemetry while protecting OEM hardware controls, battery health, and SSD lifespan.

## Features

### Smart Debloating
- Removes Microsoft bloatware (Cortana, Xbox apps, Bing apps, etc.)
- Removes third-party trialware (McAfee, Norton, Spotify, etc.)
- Preserves OEM apps (MyASUS, Lenovo Vantage, Dell Power Manager) for battery and thermal control

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
1. Download the latest release from the [Releases](https://github.com/mrcactus-afk/LaptopDebloat/releases) page.
2. Extract the ZIP file.
3. Double-click `Run.bat`.
4. Click "Yes" on the UAC prompt.
5. Follow the on-screen instructions and restart your PC when finished.

### Option 2: Run from PowerShell
1. Right-click the Start button and select "Terminal (Admin)" or "PowerShell (Admin)".
2. Paste the following command:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mrcactus-afk/LaptopDebloat/main/Debloat.ps1'))
```

## What Gets Removed

- Microsoft Bing apps (News, Weather, Finance)
- Xbox apps and gaming overlay
- Microsoft Teams (pre-installed version)
- Clipchamp
- Cortana
- Solitaire Collection
- Feedback Hub
- Maps, Alarms, Your Phone
- Third-party trialware (McAfee, Norton, Dropbox, Spotify, etc.)

## What Gets Protected

- OEM Control Centers (MyASUS, Lenovo Vantage, Dell Power Manager, HP Command Center)
- Battery charging limits (80% charge protection)
- Thermal management and fan controls
- Display and brightness management
- Audio drivers and enhancements

## Safety Features

- Creates automatic System Restore Point before making changes
- Admin privilege check before execution
- Laptop-specific optimizations (no desktop power plans)
- Reversible changes (most tweaks can be undone via System Restore)

## Disclaimer

**This script is currently in ALPHA.**

While this script is designed to be safe and hardware-aware, running system-level modifications always carries inherent risks. The author is not responsible for any issues that may occur.

**Always create a backup or System Restore Point before running system modification scripts.**

## Known Issues

- Windows Updates may re-enable some telemetry services.
- Some Microsoft Store apps may need to be reinstalled manually if removed.
- Biometric services (Windows Hello) are disabled by default - re-enable in the script if you use fingerprint/face login.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Acknowledgments

- Chris Titus Tech for inspiration and the Windows utility
- Sycnex for Windows10Debloater
- The community for testing and feedback
