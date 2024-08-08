#  How to setup Proxy for PowerShell
https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.4
Profiles are executed on PowerShell launch making it ideal for configuring the proxy

1. Run PowerShell as Admin
2. Profile path for All Users, All Hosts
```
$PROFILE.AllUsersAllHosts
```
4. Create profile file if not exists
```
if (!(Test-Path -Path $PROFILE.AllUsersAllHosts)) {
  New-Item -ItemType File -Path $PROFILE.AllUsersAllHosts -Force
}
```
5. Edit profile with notepad
```
notepad $PROFILE.AllUsersAllHosts
```
6. Add automatic proxy configuration: Windows AD SSO
```
# Configures the proxy
$Wcl = new-object System.Net.WebClient
$Wcl.Headers.Add(“user-agent”, “PowerShell Script”)
$Wcl.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
```
7. Save, Exit, and Test
```
Invoke-WebRequest https://www.google.ca
```
