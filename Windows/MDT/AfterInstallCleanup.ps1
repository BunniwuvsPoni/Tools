# Post MDT installation cleanup

# This step disables the local Administrator account
net user Administrator /active:no

# This step enables BitLocker on the C: drive
Enable-BitLocker -MountPoint “C:” -EncryptionMethod Aes128 –UsedSpaceOnly –RecoveryPasswordProtector
