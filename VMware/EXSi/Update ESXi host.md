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
4. esxcli software profile update -p <ESXi version> -d <VMware repository link>
5. Reboot host

## Update using local datastore
