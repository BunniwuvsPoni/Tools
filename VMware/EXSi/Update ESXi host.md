# How to update ESXi host

## Update directy from VMware Repository

Note:
Swap must be enabled and a datastore selected
- Host -> Manage -> System -> Swap (All set to yes and datastore selected)

Follow instructions at:
https://tinkertry.com/easy-update-to-latest-esxi
- esxcli software profile update -p <ESXi version> -d <VMware repository link>

## Update using local datastore
