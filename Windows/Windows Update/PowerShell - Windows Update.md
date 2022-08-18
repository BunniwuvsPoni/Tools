# Use PowerShell to update Windows

## Install the PSWindowsUpdate module
- Install-Module PSWindowsUpdate

## Check for updates
- Get-WindowsUpdate

## Install updates
- Install-WindowsUpdate

## Update and reboot
- Get-WindowsUpdate -AcceptAll -Install -AutoReboot
