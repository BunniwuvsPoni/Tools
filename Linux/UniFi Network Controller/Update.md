# How to update UniFi Network Controller on Debian

1. Backup/Snapshot your VM
2. Check and get the latest version of UniFi Network Controller: https://www.ui.com/download/unifi
3. Ensure the system is up to date using: sudo apt update && sudo apt full-upgrade
4. cd /tmp/
5. wget [UniFi Network Controller Link]
6. sudo dpkg -i unifi_sysvinit_all.deb
