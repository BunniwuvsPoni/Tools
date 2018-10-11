# How to setup UniFi Video on Debian

## Debian install
1. Install the latest version of Debian
    - Select only SSH server
    - Ideally configured with LVM (this will allow you to adjust the storage size later, especially useful in a VM/Hypervisor scenario)

## Update the system if needed
2. apt-get update
3. apt-get upgrade
4. apt-get dist-upgrade

## Install sudo and add user to sudo
5. apt-get install sudo
6. usermod -aG sudo (username)

## Install automatic updates
7. apt-get install unattended-upgrades
8. set the line "Unattended-Upgrade::Automatic-Reboot "true";" in /etc/apt/apt.conf.d/50unattended-upgrades to enable automatic reboots

## Install ca-certificates
9. apt-get install ca-certificates

## Install prerequisites
10. apt-get install mongodb mongodb-server openjdk-8-jre-headless jsvc psmisc

## Setup static IP
11. remove the line "iface eth0 inet dhcp" from /etc/network/interfaces
12. edit /etc/network/interfaces.d/(eth0/ens192) to the following
```
iface (eth0/ens192) inet static
address 192.168.x.x
netmask 255.255.255.0
gateway 192.168.x.x
```

## Install UniFi Video
13. Go to the temp directory
    - cd /tmp/
14. Download the installation UniFi Video deb file
    - wget (deb direct url) [Found on UBNT's website: https://www.ubnt.com/download/unifi-video]
15. Install the UniFi Video deb file
    - dpkg -i (deb file)
16. Optional, fixes dependency issues
    - apt-get -f install

## Reboot the system
17. Restart Debian to refresh the platform
