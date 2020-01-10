# How to secure wipe using Linux

## Show disk
- sudo fdisk -l
- sudo fdisk -l /dev/sdX
  - lists partitions in sdX

## HDD partition wipe
### 1. Select the disk
- sudo fdisk /dev/sdX
### 2. Delete the partitions
- "p" to print the partition table
- "d" followed by the number of the partition to delete that partition
### 3. Save the changes
- "w" to write the changes

## HDD complete wipe
- dd if=/dev/urandom of=/dev/sdX bs=4k status=progress

## SSD complete wipe
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
