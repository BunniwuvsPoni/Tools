# Post MDT installation cleanup
# Run with administrative powershell command: powershell.exe -executionpolicy bypass \\<path>\AfterInstallCleanup.ps1

# This step disables the local Administrator account
net user Administrator /active:no

# This step enables BitLocker on the C: drive
Enable-BitLocker -MountPoint “C:” -EncryptionMethod Aes128 –UsedSpaceOnly –RecoveryPasswordProtector

# This step sets up the FortiClient VPN
$Name = '<VPN Name>'
$ServerAddress = '<VPN URL>'
$AppID = 'FortinetInc.FortiClient_sq9g7krz3c65j'
Add-VPNConnection -Name $Name -ServerAddress $ServerAddress -PlugInApplicationID $AppID -CustomConfiguration '<forticlient>0</forticlient>'

# Reboot the computer
Restart-Computer -Force
