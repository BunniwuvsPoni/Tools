# How to setup Ubuntu 18.04 Desktop with TeamViewer remote access

## Install TeamViewer
Install TeamViewer from the TeamViewer website

## Disable Wayland to force Xorg
Configure /etc/gdm3/custom.conf to disable Wayland
- Uncomment out the "#" in the file
