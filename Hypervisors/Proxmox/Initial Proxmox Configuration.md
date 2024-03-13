#  Initial Proxmox configuration

## Enable DHCP (NOT FOR PRODUCTION HOSTS)
- nano /etc/network/interfaces
```
auto vmbr0
iface vmbr0 inet dhcp
	bridge-ports eno1
        bridge-stp off
        bridge-fd 0
```
- Get the hostname: cat /etc/hosts
- Create the DHCP hostname update script: nano /etc/dhcp/dhclient-exit-hooks.d/update-etc-hosts
```
if ([ $reason = "BOUND" ] || [ $reason = "RENEW" ])
then
 sed -i "s/^.*\spve-01.localdomain\s.*$/${new_ip_address} pve-01.localdomain pve-01/" /etc/hosts
Fi
```
```
Note:
On the PVE Host, the display name only updates after a 2nd reboot. 1st reboot updates the name, 2nd reboot shows the newly updated name, timing/order of operations issue…
```

##  Remove subscription message:
- SSH into the Proxmox Host or use the Host Shell (access Proxmox @ https://[ip-or-dns-name]:8006)
```
sed -Ezi.bak "s/(Ext.Msg.show\(\{\s+title: gettext\('No valid sub)/void\(\{ \/\/\1/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
```

## Update to use no-subscription repo (not for PROD systems)
- Proxmox -> Host -> Updates -> Repositories
- Disable the 2x enterprise components
- Connect to the Proxmox Host via SSH or Host Shell
- nano  /etc/apt/sources.list
```
# For Debian 12 (bookworm)
deb http://ftp.debian.org/debian bookworm main contrib
deb http://ftp.debian.org/debian bookworm-updates main contrib
						
# Proxmox VE pve-no-subscription repository provided by proxmox.com,
# NOT recommended for production use
deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription
						
# security updates
deb http://security.debian.org/debian-security bookworm-security main contrib![image](https://github.com/BunniwuvsPoni/Tools/assets/14793820/b7c4c971-1213-4d9f-9f74-c140d81f1141)

```
- In SSH/Shell, verify no 401 Unauthorized errors. Run: apt-get update

## Configure SMTP
- Connect to the Proxmox host via SSH/Shell
-  Install packages
```
apt update
apt install -y libsasl2-modules mailutils
```
- Configure credentials (note: must use app password)
- nano /etc/postfix/sasl_passwd
```
smtp.gmail.com example@gmail.com:password
```
- Update permissions
```
chmod 600 /etc/postfix/sasl_passwd
```
- Generate password database file
```
postmap hash:/etc/postfix/sasl_passwd
```
- Postfix configuration
- nano /etc/postfix/main.cf
- Comment out "#": relayhost & mydestination
- Add to the bottom of the file:
```
relayhost = smtp.gmail.com:587
smtp_use_tls = yes
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_CApath = /etc/ssl/certs
smtp_sasl_security_options = noanonymous, noplaintext
smtp_sasl_tls_security_options = noanonymous 
smtp_tls_session_cache_database = btree:/var/lib/postfix/smtp_tls_session_cache
smtp_tls_session_cache_timeout = 3600s
```
- Reload Postfix
```
postfix reload
```
- Test sending emails
- Test email:
```
echo "Test Email" | mail -s "Test Subject" example@gmail.com
```
- Proxmox relay:
```
echo "Test email from Proxmox: $(hostname)" | /usr/bin/proxmox-mail-forward
```
- Optional: Update email header
- Install packages
```
apt update
apt install postfix-pcre
```
- Configuration file
- nano /etc/postfix/smtp_header_checks
```
/^From:.*/ REPLACE From: proxmox-alert <noreply@gmail.com>
```
- Create database file
```
postmap hash:/etc/postfix/smtp_header_check
```
- Check the contents of the database file
```
cat /etc/postfix/smtp_header_checks.db
```
- Update Postfix configuration
- nano /etc/postfix/main.cf
- Add to the bottom of the file:
```
smtp_header_checks = pcre:/etc/postfix/smtp_header_checks
```
- Reload Postfix
```
postfix reload
```
- Test sending emails
- Test email:
```
echo "Test Email" | mail -s "Test Subject" example@gmail.com
```
- Proxmox relay:
```
echo "Test email from Proxmox: $(hostname)" | /usr/bin/proxmox-mail-forward
```
