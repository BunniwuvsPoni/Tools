<#
.SYNOPSIS
Add/Remove Full Access/Send As permissions in O365
.DESCRIPTION
This script is designed to connect to O365 Outlook and add/delete user permissions: Full Access (no automapping) and Send As permissions on a mailbox
Note: Exchange Online PowerShell Module must be installed on the computer running this script
.PARAMETER option
"add" or "delete" Full Access (no automapping) and Send As permissions
.PARAMETER user
The "user" you are giving pemissions to or removing permissions from
.PARAMETER mailbox
The "mailbox" you are applying the changes to
.EXAMPLE
& '.\O365 Permissions.ps1' -option add -user "<user>@<domain>.<tld>" -mailbox "<mailbox>@<domain>.<tld>"
.LINK
https://support.microsoft.com/en-ca/help/2646504/how-to-remove-automapping-for-a-shared-mailbox-in-office-365
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/connect-to-exchange-online-powershell/mfa-connect-to-exchange-online-powershell?view=exchange-ps
#>

# Required parameters to process O365 permissions change
param(
    [Parameter(Mandatory=$true)][string]$option,
    [Parameter(Mandatory=$true)][string]$user,
    [Parameter(Mandatory=$true)][string]$mailbox
)

# Connecting to O365
# Note: ExecutionPolicy should be set to "RemoteSigned"

# Note: Exchange Online PowerShell Module must be installed on the computer running this script
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

# Check if the user exists in O365
$userCheck = Get-Mailbox -Identity $user -ErrorAction SilentlyContinue | Format-List -Property PrimarySmtpAddress

if ($userCheck) {
    Write-Host "User:" $user "exists. Proceeding with script." -ForegroundColor Green
}
else {
    Write-Host "User:" $user "does not exist. Exiting script." -ForegroundColor Red
    Exit
}

# Check if the mailbox exists in O365
$mailboxCheck = Get-Mailbox -Identity $mailbox -ErrorAction SilentlyContinue | Format-List -Property PrimarySmtpAddress

if ($mailboxCheck) {
    Write-Host "Mailbox:" $mailbox "exists. Proceeding with script." -ForegroundColor Green
}
else {
    Write-Host "Mailbox:" $mailbox "does not exist. Exiting script." -ForegroundColor Red
    Exit
}

# Add or Delete Full Access and Send As permissions
# Validating option, only add or delete are accepted
if ($option -eq "add") {
    Write-Host "Option selected:" $option
    Write-Host "User specified:" $user
    Write-Host "Mailbox specified:" $mailbox
    Write-Host "Proceeding with script." -ForegroundColor Green

    # Add new permissions
    Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping:$false
    Add-RecipientPermission -Identity $mailbox -Trustee $user -AccessRights SendAs -Confirm:$false

    Write-Host "New permissions added." -ForegroundColor Green

}
elseif ($option -eq "delete") {
    Write-Host "Option selected:" $option
    Write-Host "User specified:" $user
    Write-Host "Mailbox specified:" $mailbox
    Write-Host "Proceeding with script." -ForegroundColor Green

    # Delete existing permissions
    Remove-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -Confirm:$false
    Remove-RecipientPermission -Identity $mailbox -Trustee $user -AccessRights SendAs -Confirm:$false

    Write-Host "Deleted permissions." -ForegroundColor Green
}
else {
    Write-Host "Unaccepted option:" $option". " -ForegroundColor Red
    Write-Host "Acceptable options are either 'add' or 'delete'. Exiting script."
    Exit
}

# Remove all PowerShell Sessions
Get-PSSession | Remove-PSSession

# End of script
Write-Host "End of script."
[void](Read-Host 'Press Enter to continue…')
