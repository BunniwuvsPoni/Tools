#  Setup Development VM (Python)
1. Install Windows 11: https://www.wundertech.net/how-to-install-windows-11-on-proxmox/
2. Install Qemu Guest Agent: https://pve.proxmox.com/wiki/Qemu-guest-agent
3. Update Windows 11
4. Add Ublock Origin Lite to Microsoft Edge
5. Install and configure Team Viewer
6. Install (user mode) and configure VS Code (enable Remote Tunnel Access)
7. Enable Windows 11 auto login (to start Remote Tunnel Access after computer Stops/Shutdown, it won't restart the service like with a Reboot...)
    - Regedit
        - HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
        - DWORD (32-bit) Value -> AutoAdminLogon: 1
        - String Value -> DefaultUserName
        - String Value -> DefaultPassword
    - Change screen saver: 15 mins + On resume, display logon screen
9. Install Git
    - git config --global user.name "John Doe"
    - git config --global user.email johndoe@example.com
10. Install Python (admin, add to PATH, disable length limit)
11. Configure the developmental workspace
    - https://vscode.dev/
    - Clone repository
    - Enable venv (Ctrl + Shift + P, Python: Create Environment...)
12. Install pyinstaller
    - pip install -U pyinstaller
        - pyinstaller --onefile (script)
