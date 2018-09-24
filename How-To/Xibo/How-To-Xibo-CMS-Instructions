How to setup Xibo CMS on Debian
1. Install the latest version of Debian
    - Select only SSH server
    - Ideally configured with LVM (this will allow you to adjust the storage size later, especially useful in a VM/Hypervisor scenario)

Update the system if needed
2. apt-get update
3. apt-get upgrade
4. apt-get dist-upgrade

Install sudo and add user to sudo
5. apt-get install sudo
6. usermod -aG sudo (username)

Install automatic updates
7. apt-get install unattended-upgrades
8. set the line "Unattended-Upgrade::Automatic-Reboot "true";" in /etc/apt/apt.conf.d/50unattended-upgrades to enable automatic reboots
