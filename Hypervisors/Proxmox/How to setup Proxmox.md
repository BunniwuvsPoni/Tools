# How to setup Proxmox

- Install Proxmox ideally in ZFS Raid 1 mode
- SSH into the host and disable subscription notice (this command backs up the current configuration file, replaces the subscription message, and restarts the PVE Proxy Service):

`sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service`

- Verify with (you should see void):

`grep -n -B 1 'No valid sub' /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js`
