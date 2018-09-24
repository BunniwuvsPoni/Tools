# Assuming that the hard drive on your Linux installation was configured with LVM

## To expand your storage
1. Expand the storage on the disk in your VM/Hypervisor manager

2. Boot into a live Linux OS of your choice (I am using Ubuntu)

3. Open GParted

4. If needed, click "Fix" on the error of not all space is being used

5. Resize your partition by dragging the slider all the way to the end

6. Click on "Resize" to confirm your selection

7. Click the check mark to apply

8. Click "Apply" to confirm the changes

9. Shutdown the live Linux OS

10. Boot into your system

11. df -h to check the size of your partition

12. fdisk -l to verify that your "physical" volume has been extended

13. lvextend -l +100%FREE (partition)
  -l +100$FREE allows you to select extents, in this case all free space
  -L +10G allows you to select how much storage to add, in this case 10 GB
  (partition) refers to the Filesystem found in the df -h command ran eariler

14. run resize2fs (partition) to update the actual size

15. confirm the partition has increased size using df -h

## Resources
Command:
  df -h
Result:
  The df command reports the amount of available disk space being used by file systems
  -h returns human readable results

Command:
  fdisk -l
Result:
  fdisk is a partition table manipulator for Linux
  -l list the partition tables for the specified devices and then exit
