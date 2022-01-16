# Useful information regarding GPO's

## Resetting Software Installation
 * Delete the corresponding tree from "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\AppMgmt"
   * Look for the software name in "Deployment Name"
 * Delete the corresponding key from "Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Group Policy\AppMgmt"
   * Look for the key with the same value of "Product ID" from above

## Update GPO
* In PowerShell: gpupdate /force

## Review GPO
* In PowerShell: gpresult /v
* Windows Search: rsop.msc
