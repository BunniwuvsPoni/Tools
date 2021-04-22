# How-To install and setup Unattended-Upgrades

1. Ensure the system is up to date using: sudo apt update && sudo apt full-upgrade
2. Download and install Unattended-Upgrade: sudo apt install unattended-upgrades
3. Configure Unattended-Upgrade: sudo dpkg-reconfigure -plow unattended-upgrades
4. Enable the service: sudo systemctl enable unattended-upgrades
5. Start the service: sudo systemctl start unattended-upgrades
6. Test the script: sudo unattended-upgrades --dry-run --debug
7. Verify the log: cat /var/log/unattended-upgrades/unattended-upgrades.log

Note:
To enable automatic reboots edit the file (/etc/apt/apt.conf.d/50unattended-upgrades), not recommended for servers...

Reference:
https://www.linode.com/docs/guides/how-to-configure-automated-security-updates-debian/
