<#
.SYNOPSIS
Export Mailbox, Full Access/Send As permissions to csv
.DESCRIPTION
Creates 3 csv exports (Mailboxes, users with Full Access permissions, and users with Send As permissions) taken from Exchange Online and placed into a folder "Exchange Reports" in the specified path
Note: ExecutionPolicy should be set to "RemoteSigned"
Last updated: 02/24/2020 - Updated to use Exchange Online PowerShell V2
.EXAMPLE
& '.\O365 - Export Exchange Online Permissions.ps1'
.LINK
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/exchange-online-powershell-v2/exchange-online-powershell-v2?view=exchange-ps
#>

# Export file path
$filepath = [Environment]::GetFolderPath("Desktop") + "\Exchange Reports\"

# Set domain variable
$domain = "@<domain>.<tld>"

# Connecting to O365 Exchange Online PowerShell V2
# Find the local installation of Exchange Online PowerShell V2 Module
$exchangeonlinepowershellinstalled = Get-InstalledModule -Name "ExchangeOnlineManagement"

# Check if Exchange Online Powershell Module V2 exists
if ($exchangeonlinepowershellinstalled -eq $null) {
    Write-Host "Exchange Online PowerShell Module V2 is not installed, exiting script." -ForegroundColor Red
    Exit
}
else {
    Write-Host "Exchange Online PowerShell Module V2 is installed, proceeding with script." -ForegroundColor Green
}

# Create the session (need to provide administrator username and password)
Connect-ExchangeOnline

# Creates the Reports folder on the Desktop if it does not exist
if (!(Test-Path $filepath)) {
    New-Item -ItemType Directory -Force -Path $filepath
}

Write-Host "Processing export..."

# Export-csv: All Mailboxes
Get-EXOMailbox | Where-Object {$_.UserPrincipalName -like ("*" + $domain)} | Select-Object -property DisplayName,UserPrincipalName | Export-Csv -Path ($filepath + "Mailboxes.csv") -NoTypeInformation

# Export-csv: Full Access where user identity follows the domain name
Get-EXOMailbox | Get-EXOMailboxPermission | Where-Object{$_.User -like ("*" + $domain)} | Select-Object -property Identity,User | Export-Csv -Path ($filepath + "Full_Access.csv") -NoTypeInformation

# Export-csv: Send As where trustee identity follows the domain name
Get-EXOMailbox | Get-EXORecipientPermission | Where-Object{$_.Trustee -like ("*" + $domain)} | Select-Object -property Identity,Trustee | Export-Csv -Path ($filepath + "Send_As.csv") -NoTypeInformation

# Remove all PowerShell Sessions
Get-PSSession | Remove-PSSession

# End of script
Write-Host "Export completed."
[void](Read-Host 'Press Enter to continue…')
