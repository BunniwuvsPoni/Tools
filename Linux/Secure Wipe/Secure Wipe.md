# How to secure wipe using Linux

## Show disk
- sudo fdisk -l

## HDD
- dd if=/dev/urandom of=/dev/sdX bs=4k status=progress

## SSD
### 1. Check that the drive is not frozen
- hdparm -I /dev/sda
### 2. Set the user password
- hdparm --user-master u --security-set-pass <password> /dev/sda
### 3. Check that security has been enabled
- hdparm -I /dev/sda
### 4. Secure erase
- hdparm --user-master u --security-erase <password> /dev/sda
### 5. Check that security has been disabled
- hdparm -I /dev/sda
