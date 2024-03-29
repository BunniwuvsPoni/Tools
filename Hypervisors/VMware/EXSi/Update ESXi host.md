# How to update ESXi host

## Update directy from VMware Repository

Note:
Swap must be enabled and a datastore selected
- Host -> Manage -> System -> Swap (All set to yes and datastore selected)

Follow instructions at:
https://tinkertry.com/easy-update-to-latest-esxi

1. Enable maintenance mode
2. Shutdown VMs
3. Restart ESXi host
4. Enable ESXi SSH
5. Connect to SSH
6. Backup ESXi configuration
7. esxcli software profile update -p (ESXi version) -d (VMware repository link)
8. Restart ESXi host
9. Enable ESXi SSH
10. Check the version: esxcli system version get
11. Backup ESXi configuration
12. Restart ESXi host
13. Disable maintenance mode
14. Start VMs

## Update using local datastore
Follow instructions at:
https://www.vembu.com/blog/how-to-update-to-esxi-6-7-update-3-using-command-line/

1. Upload [VMware vSphere Hypervisor (ESXi) Offline Bundle] to datastore
2. Enable maintenance mode
3. Shutdown VMs
4. Restart ESXi host
5. Enable ESXi SSH
6. Connect to SSH
7. Backup ESXi configuration
8. esxcli software vib install -d “/vmfs/volumes/Datastore/DirectoryName/(vSphere ESXi offline bundle).zip”
9. Restart ESXi host
10. Enable ESXi SSH
11. Check the version: esxcli system version get
12. Backup ESXi configuration
13. Restart ESXi host
14. Disable maintenance mode
15. Start VMs

## Backup ESXi configuration
https://kb.vmware.com/s/article/2042141

## Restart ESXi host
https://vdc-download.vmware.com/vmwb-repository/dcr-public/24be7af7-d9cd-48d9-bab8-8c91614be19d/0ca33108-8017-4b40-86b9-f066456894ea/doc/GUID-73ED2338-D29D-411F-8B7B-35DFB1871EA3.html
