# How to update UniFi Network Controller on Debian

1. Snapshot your VM
2. Check and get the latest version of UniFi Network Controller: https://www.ui.com/download/unifi
3. Ensure the system is up to date using: sudo apt update && sudo apt full-upgrade
4. Switch to the temporary directory: cd /tmp/
5. Download the latest version: wget [UniFi Network Controller Link]
6. Install the package: sudo dpkg -i unifi_sysvinit_all.deb
7. Restart the OS: sudo shutdown -r now
8. Remove Snapshot if all looks well
