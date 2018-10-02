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
13. Update package list
    - apt-get update
14. Install the latest Docker CE
    - apt-get install docker-ce
15. Install the latest Docker-Compose
    - https://github.com/docker/compose/releases
    - For version 1.22.0:
        - curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
        - chmod +x /usr/local/bin/docker-compose

## Install Xibo CMS
16. Go to the temp directory
    - cd /tmp/
17. Download the installation Xibo .tar.gz file
    - wget (deb direct url) [Found on Xibo's website: https://xibo.org.uk/manual/en/install_docker_linux.html]
18. Create Xibo directory in /opt/
    - mkdir /opt/Xibo
19. Extract Xibo files from archive
    - tar -xf file_name.tar.gz -C /opt/Xibo
20. Go to your extracted file location
    - cd /opt/Xibo/(Xibo version)/
21. Copy the config template
    - cp config.env.template config.env
22. Within the config.env file, input a password into "MYSQL_PASSWORD=" (Random password generator: https://www.random.org/passwords/?num=1&len=16&format=plain&rnd=new)
23. Start the Docker Container (Work in progress)
    - docker-compose up -d

## Setup static IP
x. remove the line "iface eth0 inet dhcp" from /etc/network/interfaces
x. edit /etc/network/interfaces.d/eth0 to the following
```
iface eth0 inet static
address 192.168.x.x
netmask 255.255.255.0
gateway 192.168.x.x
```
