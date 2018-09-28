# How to setup Xibo CMS on Debian

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

## Install Docker - Prerequisite for running Xibo
9. Install packages to allow apt to use a repository over HTTPS
    - apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
10. Add Docker's offical GPG key
    - curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
11. Verify that you now have the key
    - sudo apt-key fingerprint 0EBFCD88
12. Setup the stable repository
    - sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
13. apt-get update
14. apt-get install docker-ce

## Setup static IP
x. remove the line "iface eth0 inet dhcp" from /etc/network/interfaces
x. edit /etc/network/interfaces.d/eth0 to the following
```
iface eth0 inet static
address 192.168.x.x
netmask 255.255.255.0
gateway 192.168.x.x
```
