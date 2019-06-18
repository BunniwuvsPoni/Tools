# Linux Services

## How-To create a Linux service

### 1. Create your bash script in a location of your choosing
- Note: remember to include the <<shebang>> line (#!/bin/bash)

### 2. Change permissions on your script so that root can execute
- chmod 755 <script name>.sh

### 3. Create your <service>.service file in /etc/systemd/system/
    [Install]
    WantedBy=multi-user.target
    
    [Unit]
    Description=<service description>
    Wants=network-online.target
    After=network-online.target
    
    [Service]
    Type=simple
    User=root
    Group=root
    ExecStart=<filepath to script>

### 4. Reload the systemctl daemon (systemctl daemon-reload)

### 5. Restart your server to confirm that service runs on startup
