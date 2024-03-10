#  Setup LXC-CT
- Download the Debian template
- Create CT
- Disable ipv6 for console connection timeout
- nano /etc/sysctl.conf
- Add entries at the bottom:
```
net.ipv6.conf.all.disable_ipv6 =1
net.ipv6.conf.default.disable_ipv6 =1
net.ipv6.conf.lo.disable_ipv6 =1
```
- Enable "Start at boot" option for the LXC/CT
