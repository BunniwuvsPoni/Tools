# Post MDT installation cleanup
# Run with administrative powershell command: powershell.exe -executionpolicy bypass \\<path>\AfterInstallCleanup.ps1

# This step disables the local Administrator account
net user Administrator /active:no

# This step activates Windows with the original OEM key
$Productkey = (Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductkey # Get the original OEM key
slmgr.vbs -ipk $Productkey # Install the OEM key
slmgr.vbs -ato # Activate the OEM key with Microsoft online

# This step enables BitLocker on the C: drive
Enable-BitLocker -MountPoint “C:” -EncryptionMethod Aes128 –UsedSpaceOnly –RecoveryPasswordProtector

# Reboot the computer
Restart-Computer
