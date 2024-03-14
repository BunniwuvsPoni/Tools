#  Initial Proxmox Backup Server (virtualized-lxc) Setup
## Install Proxmox Backup Server
- Connect to the Promox Host via SSH/Shell and subsequently the lxc for the PBS
- Add the Proxmox Backup Server no-subscription repo (not for PROD systems)
- nano /etc/apt/sources.list
```
# For Debian 12 (bookworm)
deb http://deb.debian.org/debian bookworm main contrib
deb http://deb.debian.org/debian bookworm-updates main contrib
					
# Proxmox Backup Server pbs-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pbs bookworm pbs-no-subscription
					
# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib![image](https://github.com/BunniwuvsPoni/Tools/assets/14793820/1fda20e8-6df5-4ee9-a98e-d72561bcba26)

```
- Add Proxmox key
```
wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
```
- Update the APT:
```
apt update
```
- Install Proxmox Backup Server:
```
apt install proxmox-backup-server
```
- Disable the enterprise repo
```
nano /etc/apt/sources.list.d/pbs-enterprise.list
```
- Remove the subscription message:
```
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart proxmox-backup-proxy.service
```
- Verify
```
grep -n -B 1 'No valid sub' proxmoxlib.js
```
- Access the PBS @ https://[ip-or-dns-name]:8007
- Username: root
- Password: (password of the root user on the Debian lxc instance)

## Proxmox Virtual Environment and Proxmox Backup Server (LXC-Unprivileged) Integration
- Update PVE and PBS LXC:
```
apt update && apt full-upgrade
```
- Create a pbs-backup folder in /rpool/ OR Create ZFS on PVE Host running PBS LXC
- Change ownership of PVE Host folder to 1000:1000
```
chown 1000:1000 /(PVE zfs pool)
```
- Confirm ownership changes
```
ls -l
```
- Add in PVE Host root:1000:1 to /etc/subuid and /etc/subgid
```
echo "root:1000:1" >> /etc/subuid
echo "root:1000:1" >> /etc/subgid
```
- Confirm addition
```
cat /etc/subuid
cat /etc/subgid
```
- Add in PVE Host mountpoint to LXC
- nano /etc/pve/lxc/(PBS LXC).conf
- Append to the end of the file:
```
mp0: /(PVE zfs pool)/,mp=/mnt/(PBS mountpoint)
```
- Add in PVE Host LXC id mapping, only maps uid/gid 1000: nano /etc/pve/lxc/(PBS LXC).conf
```
lxc.idmap: u 0 100000 1000
lxc.idmap: g 0 100000 1000
lxc.idmap: u 1000 1000 1
lxc.idmap: g 1000 1000 1
lxc.idmap: u 1001 101001 64535
lxc.idmap: g 1001 101001 64535
```
- Add in PBS LXC user "pbs-[hostname]" with uid/gid 1000
```
useradd -u 1000 -m -s /usr/bin/bash pbs-[hostname]
```
```
-m creates user's home directory
-s name of the user's login shell
```
- Confirm user and group creation
```
cat /etc/passwd
cat /etc/group
```
- Reboot PBS LXC
- Add in PBS LXC Datastore linked to the mountpoint created in previous step
	- Retention: Prune Options
 		- Keep Last: 365 Days
   		- [https://pbs.proxmox.com/docs/prune-simulator/]
	 	- Pruning configured at PBS LXC rather than PVE Storage/Backup Job level…
   	- Verify Jobs
   		- Daily @ 5am
   	 	- Skip Verified
   	  	- Re-Verify after 30 days
- Create new user in PBS LXC
- In PBS LXC, give the new user Datastore.Backup permissions to the Datastore
- In PBS LXC, under the Dashboard, get the Fingerprint
- In PVE, add the PBS under Datacenter -> Storage
- PVE, create backup under Datacenter -> Backup
	- Storage: PBS Storage
 	- Daily @ 3am
  	- Exclude selected VM: PBS LXC
  		- What's the point of backing up the PBS when you need the PBS to perform a restore?
  	- Mode: Snapshot


## Notes
- LXC: Read whole container -> Low data storage requirements
- VM: Can take advantage of de-duplication -> Large data storage requirements
