# How to setup TeamViewer on Linux (Ubuntu)
1. cd /tmp/
2. wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
3. sudo apt install ./teamviewer_amd64.deb

Note: Ubuntu may not allow you connect when at the login page, to work around this issue, use the following steps...
1. sudo gedit /etc/gdm3/custom.conf
2. Uncomment the line: "WaylandEnable=false"
3. reboot
