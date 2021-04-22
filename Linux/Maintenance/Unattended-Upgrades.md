# How-To install and setup Unattended-Upgrades

1. Ensure the system is up to date using: sudo apt update && sudo apt full-upgrade
2. Download and install Unattended-Upgrade: sudo apt install unattended-upgrades
3. Configure Unattended-Upgrade: sudo dpkg-reconfigure -plow unattended-upgrades
4. Verify the status of the service: systemctl status unattended-upgrades
    - Enable the service: sudo systemctl enable unattended-upgrades
    - Start the service: sudo systemctl start unattended-upgrades
7. Test the script: sudo unattended-upgrades --dry-run --debug
8. Verify the log: cat /var/log/unattended-upgrades/unattended-upgrades.log

Note:
To enable automatic reboots edit the file (/etc/apt/apt.conf.d/50unattended-upgrades), not recommended for servers...

Reference:
https://linuxize.com/post/how-to-set-up-automatic-updates-on-ubuntu-18-04/
