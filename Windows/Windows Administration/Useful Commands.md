# Useful commands for troubleshooting

## Windows Server
* nltest
  * /DSGETDC:<DomainName> - Get currently connected DC
  * /SC_RESET:<DomainName>[\<DcName>] - Reset secure channel for <Domain> on <ServerName> to <DcName> (nltest /Server:ClientComputerName /SC_RESET:DomainName\DomainControllerName)
  * /DCLIST:<DomainName> - Get list of DC's for <DomainName>
  * /DCNAME:<DomainName> - Get the PDC name for <DomainName>
  * /DNSGETDC:<DomainName> - Queries the DNS server for a list of domain controllers and their corresponding IP addresses.
  * /DSGETSITE - Returns the name of the site in which the domain controller resides.

## Test user credentials
 * Start-Process -FilePath cmd.exe /c -Credential (Get-Credential)
 
## BitLocker
*  Back up existing key to AD
    * manage-bde -protectors -get c:
    * manage-bde -protectors -adbackup c: -id '{<ID from the previous command>}'
*  Enable BitLocker
    * Enable-BitLocker -MountPoint “D:” -EncryptionMethod Aes128 –UsedSpaceOnly –RecoveryPasswordProtector

## Local Administrator account
*  How-To disable local Administrator account
    * net user Administrator /active:no

## Find logged on user on a remote computer
*  Get-WmiObject –ComputerName (Remote Computer Name) –Class Win32_ComputerSystem | Select-Object UserName

## Battery Report
* powercfg /batteryreport

## System Information
* In PowerShell: SystemInfo
* Windows Search: System Information

## Test NTP
 * time.windows.com
    * w32tm /stripchart /computer:time.windows.com /dataonly /samples:5
 * Current time zone
    * w32tm /tz
 * List NTP peers
    * w32tm /query /peers
 
## Get remote computer Name and Boot Time
 * .\systeminfo.exe /s (Remote Computer Name) | findstr /C:"Host Name:" /C:"Boot Time:"

## Remote System Uptime
* systeminfo.exe /s (host) | find "System Boot Time"
 
 
## Startup Applications
 - Shell:Startup
   - For your own profile
 - Shell:Common Startup
   - For all profiles
 
 ## rdpsign
 - rdpsign.exe /sha256 ("Thumbprint of Self-Signed SSL Certificate").ToUpper().Replace(" ","") '.\Remote Desktop.rdp'
 https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/rdpsign
