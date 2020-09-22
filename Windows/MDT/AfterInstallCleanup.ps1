# Post MDT installation cleanup
# Run with administrative powershell command: powershell.exe -executionpolicy bypass \\<path>\AfterInstallCleanup.ps1

# This step disables the local Administrator account
net user Administrator /active:no

# This step enables BitLocker on the C: drive
Enable-BitLocker -MountPoint “C:” -EncryptionMethod Aes128 –UsedSpaceOnly –RecoveryPasswordProtector

# Reboot the computer
Restart-Computer -Force
