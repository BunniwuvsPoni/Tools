# How to setup Proxmox

- Install Proxmox ideally in ZFS Raid 1 mode
- SSH into the host and disable subscription notice:
  - sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
    - This command backs up the current configuration file, replaces the subscription message, and restarts the PVE Proxy Service
