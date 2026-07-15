# 🚀 Ultimate Windows 11 Optimization & Debloat Script

A lightweight, transparent, and safe PowerShell alternative to GUI tools like *Winhance*. This script removes bloatware, disables invasive telemetry and AI features, optimizes Windows Update, applies quality-of-life UI tweaks, and configures your system for maximum gaming performance—all without installing third-party software.

## ⚠️ Disclaimer
**Use at your own risk.** While this script is designed to be safe and non-destructive, it modifies system settings and the registry. **Always create a System Restore point** before running optimization scripts. 

## ✨ Features
- **Safe Debloating:** Removes pre-installed Windows bloatware (Copilot, Edge shortcuts, Clipchamp, etc.) without breaking core system components like WebView2.
- **Privacy & Telemetry:** Disables advertising IDs, tailored experiences, and optional diagnostic data while keeping *Required* telemetry intact to ensure Windows Update doesn't break.
- **AI & Copilot Removal:** Completely disables Windows Copilot and AI data analysis features via Registry.
- **Windows Update Control:** Stops Windows from automatically installing third-party drivers and prevents forced auto-reboots.
- **UI & Explorer Tweaks:** Restores the classic Windows 10 right-click context menu, enables Dark Mode, hides the search/task view buttons, and shows file extensions.
- **Gaming & Power Optimization:** Enables Game Mode, sets the power plan to High Performance, and disables USB selective suspend.
- **Bonus DNS Config:** Includes an optimized `DNSJumper.ini` file tailored for low-latency gaming in Iran (Radar Game, Lag Zero, Electro).

## 🛠️ How to Use

### 1. Run the PowerShell Script
1. Download or clone this repository.
2. Right-click on `Optimize-Windows.ps1` and select **"Run with PowerShell"**.
   *(Alternatively, open PowerShell as Administrator and run: `.\Optimize-Windows.ps1`)*
3. The script will automatically request Administrator privileges if needed.
4. Follow the on-screen prompts. Restart your PC when finished.

### 2. Apply the Gaming DNS Config (Optional)
1. Download [DNS Jumper](https://www.sordum.org/).
2. Replace the default `DNSJumper.ini` file in the DNS Jumper folder with the `DNSJumper.ini` provided in this repo.
3. Open DNS Jumper, click **Fastest DNS**, and apply the lowest ping Iranian server (usually Radar Game or Lag Zero).

## 📂 Repository Structure
- `Optimize-Windows.ps1` - The main optimization script.
- `DNSJumper.ini` - Custom DNS configuration for low-latency gaming.
- `README.md` - This file.

## 🤝 Contributing
Feel free to open an Issue or submit a Pull Request if you have suggestions for more safe and effective tweaks!
