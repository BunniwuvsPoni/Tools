# How to update ESXi host

## Update directy from VMware Repository

Note:
Swap must be enabled and a datastore selected
- Host -> Manage -> System -> Swap (All set to yes and datastore selected)

Follow instructions at:
https://tinkertry.com/easy-update-to-latest-esxi

1. Enable maintenance mode
2. Shutdown VMs
3. Restart host
4. Enable ESXi SSH
5. Connect to SSH
6. Backup ESXi configuration
7. esxcli software profile update -p (ESXi version) -d (VMware repository link)
8. Reboot host
9. Enable ESXi SSH
10. Check the version: esxcli system version get
11. Backup ESXi configuration
12. Disable maintenance mode

## Update using local datastore
Follow instructions at:
https://www.vembu.com/blog/how-to-update-to-esxi-6-7-update-3-using-command-line/

1. Upload [VMware vSphere Hypervisor (ESXi) Offline Bundle] to datastore
2. Enable maintenance mode
3. Shutdown VMs
4. Restart host
5. Enable ESXi SSH
6. Connect to SSH
7. Backup ESXi configuration
8. esxcli software vib install -d “/vmfs/volumes/Datastore/DirectoryName/(vSphere ESXi offline bundle).zip”
9. Reboot host
10. Enable ESXi SSH
11. Check the version: esxcli system version get
12. Backup ESXi configuration
13. Disable maintenance mode

## Backup ESXi configuration
https://kb.vmware.com/s/article/2042141
