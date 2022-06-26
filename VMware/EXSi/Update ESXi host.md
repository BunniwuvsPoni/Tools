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
4. Backup ESXi configuration
5. esxcli software profile update -p (ESXi version) -d (VMware repository link)
6. Reboot host
7. Check the version: esxcli system version get
8. Backup ESXi configuration

## Update using local datastore
Follow instructions at:
https://www.vembu.com/blog/how-to-update-to-esxi-6-7-update-3-using-command-line/

1. Upload [VMware vSphere Hypervisor (ESXi) Offline Bundle] to datastore
2. Enable maintenance mode
3. Restart host
4. Connect to SSH
5. Backup ESXi configuration
6. esxcli software vib install -d “/vmfs/volumes/Datastore/DirectoryName/(vSphere ESXi offline bundle).zip”
7. Reboot host
8. Check the version: esxcli system version get
9. Backup ESXi configuration

## Backup ESXi configuration
https://kb.vmware.com/s/article/2042141

ESXi Command Line
Backing up ESXi host configuration data
To synchronize the configuration changed with persistent storage, run this command:
vim-cmd hostsvc/firmware/sync_config
To back-up the configuration data for an ESXi host, run this command:
vim-cmd hostsvc/firmware/backup_config

Note: The command will output a URL (http://*/downloads/123456/configBundle-xx.xx.xx.xx.tgz) in which a web browser may be used to download the file.

* denotes the host IP/FQDN.
From a web browser navigate to http://Host_FQDN/downloads/123456/configBundle-xx.xx.xx.xx.tgz
In this example the IP address of the host is 192.168.0.81

The backup file will be in the /downloads directory (default to browser or choose to download to a specific directory) as configBundle-HostFQDN.tgz

Note: To restore the configuration the destination ESXi host must be the same build as the ESXi host configuration data. The host build can be obtained using the command vmware -vl .
