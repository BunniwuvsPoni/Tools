# How to setup Ubuntu 18.04 Desktop with TeamViewer remote access

## Install TeamViewer
Install TeamViewer from the TeamViewer website

## Disable Wayland to force Xorg
Configure /etc/gdm3/custom.conf to disable Wayland
- Uncomment out the "#" in the file

## Setup xserver-xorg-video-dummy
Install xserver-xorg-video-dummy with the following settings created in /usr/share/X11/xorg.conf.d/xorg.conf
---
Section "Device"
Identifier "Configured Video Device"
Driver "dummy"
EndSection

Section "Monitor"
Identifier "Configured Monitor"
HorizSync 31.5-48.5
VertRefresh 50-70
EndSection

Section "Screen"
Identifier "Default Screen"
Monitor "Configured Monitor"
Device "Configured Video Device"
DefaultDepth 24
SubSection "Display"
Depth 24
Modes "1024x800"
EndSubSection
EndSection
---
