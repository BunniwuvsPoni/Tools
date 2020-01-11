# How to secure wipe using Linux
- HDD - When a file gets deleted, only the index/pointer is deleted. This is why you overwrite the entire disk.
- SSD - When a file gets deleted, TRIM deletes the file from storage for performance reasons (unlike the hard drive, solid state drives cannot "paint" over the data like hard drives do, it must delete the existing data first). To ensure a complete wipe, run the secure erase command.

## Show disk
- sudo fdisk -l
- sudo fdisk -l /dev/sdX
  - lists partitions in sdX

## HDD partition wipe - Linux
### 1. Select the disk
- sudo fdisk /dev/sdX
### 2. Delete the partitions
- "p" to print the partition table
- "d" followed by the "#" of the partition to delete that partition
### 3. Save the changes
- "w" to write the changes

## HDD complete wipe - Linux
- dd if=/dev/urandom of=/dev/sdX bs=4k status=progress

## SSD complete wipe - Linux
### 1. Check that the drive is not frozen
- hdparm -I /dev/sda
### 2. Set the user password
- hdparm --user-master u --security-set-pass <password> /dev/sda
### 3. Check that security has been enabled
- hdparm -I /dev/sda
### 4. Secure erase
- hdparm --user-master u --security-erase <password> /dev/sda
- hdparm --user-master u --security-erase-enhanced p /dev/sda - if the drive supports enhanced erase
### 5. Check that security has been disabled
- hdparm -I /dev/sda
### 6. Check that there is nothing in the first few MBs of the disk (should output nothing)
- dd if=/dev/sda bs=1M count=5

---

## SSD trim status (should be enabled by default Windows 7 or higher on SSDs)
### 0 means TRIM is enabled, 1 means TRIM  is disabled
- fsutil behavior query DisableDeleteNotify

## HDD complete wipe - DBAN

## SSD complete wipe - Windows
- PartedMagic has good reviews and support
- Utility from SSD manufacturer
- BIOS secure erase
