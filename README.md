# Tier-1 Laptop Windows 11 Debloater

A hardware-safe, laptop-optimized PowerShell script designed to remove bloatware, disable invasive telemetry and AI features, and optimize system performance. Unlike generic debloaters, this script is specifically engineered to protect OEM hardware controls, battery health, and SSD lifespan.

## Features

### Core Optimizations
- Smart Debloating: Removes Microsoft bloatware and third-party trialware while preserving OEM apps (MyASUS, Lenovo Vantage, etc.) for battery and fan control.
- Privacy and Telemetry: Disables advertising IDs, tailored experiences, and optional diagnostic data while keeping Required telemetry intact to ensure Windows Update stability.
- AI and Copilot Removal: Completely disables Windows Copilot and AI data analysis features via the Registry.
- Windows Update Control: Prevents Windows Update from automatically installing third-party drivers and stops forced auto-reboots.
- Service Optimization: Disables unnecessary background services to reduce RAM and CPU usage.
- Network and Gaming Stack: Tunes TCP settings, enables Game Mode, and optimizes network throttling for lower latency.
- UI Cleanup: Restores the classic Windows 10 right-click context menu, hides Cortana and Task View, and shows file extensions.

### Laptop-Specific Protections
- SSD Protection: Disables Fast Startup and Hibernation to reduce solid-state drive wear.
- Battery and Thermal Safety: Forces the Balanced power plan to prevent thermal throttling and preserve battery health.
- OEM App Preservation: Keeps manufacturer-specific applications for critical hardware control.

## Known Limitations

Please review these changes before running the script:
- Start Menu Search is disabled (WSearch service is stopped). Use File Explorer search instead.
- Xbox services are disabled. This script is not compatible with Xbox Game Pass.
- Hibernation is disabled. Only Sleep and Shutdown modes are available.
- Power plan is set to Balanced. This is optimized for battery life and thermals, not maximum gaming performance.

## Installation and Usage

### Method 1: Using the Batch File (Recommended)
1. Download or clone this repository to your local machine.
2. Right-click on Run.bat and select "Run as administrator".
3. A command prompt will appear. Type Y and press Enter to confirm and proceed.
4. Wait for the script to finish executing.
5. Restart your PC to finalize all changes.

### Method 2: Manual PowerShell Execution
1. Download or clone this repository.
2. Right-click on Optimize-Windows.ps1 and select "Run with PowerShell".
3. Alternatively, open PowerShell as Administrator and execute:
   .\Optimize-Windows.ps1
4. Type Y to confirm the disclaimer and proceed.
5. Restart your PC when the script completes.

## Configuration: Gaming DNS

This repository includes an optimized DNSJumper.ini file tailored for low-latency gaming in Iran, featuring servers like Radar Game, Lag Zero, and Electro.

To apply this configuration:
1. Download DNS Jumper from the official Sordum website.
2. Extract the DNS Jumper archive.
3. Replace the default DNSJumper.ini file in the extracted folder with the DNSJumper.ini provided in this repository.
4. Open DNS Jumper, click on Fastest DNS, and apply the server with the lowest ping.

## Repository Structure

- Optimize-Windows.ps1: The main laptop optimization and debloat script.
- Run.bat: Batch file to automatically run the script with administrator privileges.
- DNSJumper.ini: Custom DNS configuration for low-latency gaming.
- README.md: This documentation file.

## Contributing

Contributions, issues, and feature requests are welcome. 
1. Fork the repository.
2. Create your feature branch (git checkout -b feature/YourFeature).
3. Commit your changes (git commit -m 'Add some feature').
4. Push to the branch (git push origin feature/YourFeature).
5. Open a Pull Request.

## License

Distributed under the MIT License. See the LICENSE file for more information.
