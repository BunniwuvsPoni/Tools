# Windows Automatic Logon

https://learn.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon

Regedit: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon

Add
- DWORD (32 Bit) value - AutoAdminLogon - 1
- String Value - DefaultUserName
- String Value - DefaultPassword
