#  Initial Proxmox Backup Server (virtualized-lxc) Setup
## Install Proxmox Backup Server
- Add the Proxmox Backup Server no-subscription repo
- nano /etc/apt/sources.list
```
# For Debian 12 (bookworm)
deb http://deb.debian.org/debian bookworm main contrib
deb http://deb.debian.org/debian bookworm-updates main contrib
					
# Proxmox Backup Server pbs-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pbs bookworm pbs-no-subscription
					
# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib![image](https://github.com/BunniwuvsPoni/Tools/assets/14793820/1fda20e8-6df5-4ee9-a98e-d72561bcba26)

```
- Add Proxmox key
```
wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
```
- Update the APT:
```
apt update
```
- Install Proxmox Backup Server:
```
apt install proxmox-backup-server
```
- Remove the subscription message:
```
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart proxmox-backup-proxy.service
```
- Access the PBS @ https://[ip-or-dns-name]:8007
- Username: root
- Password: (password of the root user on the Debian lxc instance)
