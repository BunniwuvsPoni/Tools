# Group Policy Settings for OneDrive - Windows Known Folders - Desktop

## Files
Destination File:

%OneDrive%\Desktop\\(file).(extension)

Remember to check off:

"Run in logged-on user's security context (user policy option)"

## Shortcuts (PowerShell Script version)
Target Type:

File System Object

Location:

Desktop

Target path:

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe

Arguments:

-executionpolicy bypass -file "(file path)"
