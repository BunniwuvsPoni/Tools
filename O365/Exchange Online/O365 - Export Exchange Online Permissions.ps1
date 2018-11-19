<#
.SYNOPSIS
Export Mailbox, Full Access/Send As permissions to csv
.DESCRIPTION
Creates 3 csv exports of Mailboxes, users with Full Access permissions, and users with Send As permissions from Exchange Online into a folder "Exchange Reports" on the user's desktop
Note: Exchange Online PowerShell Module (installer only works via Internet Explorer) must be installed on the computer running this script
Note: ExecutionPolicy should be set to "RemoteSigned"
.EXAMPLE
& '.\O365 - Export Exchange Online Permissions.ps1'
.LINK
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps
#>


# Log file path
$desktoppath = [Environment]::GetFolderPath("Desktop") + "\Exchange Reports\"

# Set domain variable
$domain = "@<domain>.<tld>"

# Connecting to O365 Exchange Online PowerShell

# Find the local installation of Exchange Online PowerShell Module
$targetdir = (dir $env:LOCALAPPDATA”\Apps\2.0\” -Include CreateExoPSSession.ps1,Microsoft.Exchange.Management.ExoPowershellModule.dll -Recurse | Group Directory | ? {$_.Count -eq 2}).Values | sort LastWriteTime -Descending | select -First 1 | select -ExpandProperty FullName

# Check if $targetdir exists
if ($targetdir -eq $null) {
    Write-Host "Exchange Online PowerShell Module is not installed, exiting script." -ForegroundColor Red
    Exit
}
else {
    Write-Host "Exchange Online PowerShell Module is installed, proceeding with script." -ForegroundColor Green
    
    # Import the local installation of Exchange Online PowerShell Module
    Import-Module $targetdir\CreateExoPSSession.ps1
}

# Create the session
Connect-EXOPSSession

# Creates the Reports folder on the Desktop if it does not exist
if (!(Test-Path $desktoppath)) {
    New-Item -ItemType Directory -Force -Path $desktoppath
}

# Export-csv: Mailboxes
Get-Mailbox | Where-Object {$_.UserPrincipalName -like ("*" + $domain)} | Select-Object -property DisplayName,UserPrincipalName | Export-Csv -Path ($desktoppath + "Mailboxes.csv") -Append

# Export Full Access and Send As permissions on a per user basis
$users = Get-Mailbox | Where-Object {$_.UserPrincipalName -like ("*" + $domain)} | Select-Object -property DisplayName,UserPrincipalName,Alias

Write-Host "Processing may take a few minutes, please be patient..."

foreach ($user in $users) {
    
    Write-Host "Processing mailbox:" $user.Alias

    # Export-csv: Full Access
    Get-Mailbox | Get-MailboxPermission -User $user.Alias | Export-Csv -Path ($desktoppath + "Full Access.csv") -Append

    # Export-csv: Send As
    Get-Mailbox | Get-RecipientPermission -Trustee $user.Alias | Export-Csv -Path ($desktoppath + "Send As.csv") -Append
}


# Remove all PowerShell Sessions
Get-PSSession | Remove-PSSession

# End of script
Write-Host "End of script."
[void](Read-Host 'Press Enter to continue…')
