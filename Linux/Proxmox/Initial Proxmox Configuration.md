#  Initial Proxmox configuration
##  Remove subscription message:
- SSH into the Proxmox Host or use the Host Shell (access Proxmox @ https://[ip-or-dns-name]:8006)
```
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
```

## Update to use no-subscription repo (not for PROD systems)
- Proxmox -> Host -> Updates -> Repositories
- Disable the 2x enterprise components
- Connect to the Proxmox Host via SSH or Host Shell
- nano  /etc/apt/sources.list
```
# For Debian 12 (bookworm)
deb http://ftp.debian.org/debian bookworm main contrib
deb http://ftp.debian.org/debian bookworm-updates main contrib
						
# Proxmox VE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
						
# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib![image](https://github.com/BunniwuvsPoni/Tools/assets/14793820/b7c4c971-1213-4d9f-9f74-c140d81f1141)

```
- In SSH/Shell, verify no 401 Unauthorized errors. Run: apt-get update
