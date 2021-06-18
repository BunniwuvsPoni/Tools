# How to update ESXi host

## Update directy from VMware Repository

Note:
Swap must be enabled and a datastore selected
- Host -> Manage -> System -> Swap (All set to yes and datastore selected)

Follow instructions at:
https://tinkertry.com/easy-update-to-latest-esxi

1. Enable maintenance mode
2. Restart host
3. Connect to SSH
4. esxcli software profile update -p (ESXi version) -d (VMware repository link)
5. Reboot host
6. Check the version: esxcli system version get

## Update using local datastore
Follow instructions at:
https://www.vembu.com/blog/how-to-update-to-esxi-6-7-update-3-using-command-line/

1. Upload [VMware vSphere Hypervisor (ESXi) Offline Bundle] to datastore
2. Enable maintenance mode
3. Restart host
4. Connect to SSH
5. esxcli software vib install -d “/vmfs/volumes/Datastore/DirectoryName/(vSphere ESXi offline bundle).zip”
6. Reboot host
7. Check the version: esxcli system version get
