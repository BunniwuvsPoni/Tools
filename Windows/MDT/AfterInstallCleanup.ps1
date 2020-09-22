# Post MDT installation cleanup
# Run with administrative powershell command: powershell.exe -executionpolicy bypass \\<path>\AfterInstallCleanup.ps1

# This step disables the local Administrator account
net user Administrator /active:no

# This step enables BitLocker on the C: drive
Enable-BitLocker -MountPoint “C:” -EncryptionMethod Aes128 –UsedSpaceOnly –RecoveryPasswordProtector

# This step adds the wireless network profile
netsh wlan add profile filename="\\<path>\<Wireless Profile File Name>.xml" user=all

# Reboot the computer
Restart-Computer -Force
