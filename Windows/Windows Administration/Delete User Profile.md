# How to delete a User's profile

1. Rename/delete the user's profile from (C:\Users)
2. Delete the user's folder in Registry Editor (HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList)

Run command:
Get-CimInstance -Class Win32_UserProfile | Where-Object { $_.LocalPath.split(‘\’)[-1] -eq '<userprofile>' } | Remove-CimInstance
