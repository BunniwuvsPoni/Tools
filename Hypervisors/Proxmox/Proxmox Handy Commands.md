#  Proxmox Handy Commands.md
## LXC/CT
- Get LXC IDs
```
lxc-ls -f
```
- Get LXC IP address
```
lxc-info -n <CONTAINER ID>
```
- SSH to LXC/CT, connect to the Promox Host via SSH/Shell:
```
lxc-attach --name <Container ID>
```
