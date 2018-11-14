<#
.SYNOPSIS
Add/Remove Full Access/Send As permissions in O365
.DESCRIPTION
This script is designed to connect to O365 Outlook and add/delete user permissions: Full Access (no automapping) and Send As permissions on a mailbox
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
#>

# Required parameters to process O365 permissions change
param(
    [Parameter(Mandatory=$true)][string]$option,
    [Parameter(Mandatory=$true)][string]$user,
    [Parameter(Mandatory=$true)][string]$mailbox
)

# Connecting to O365
# Note: ExecutionPolicy should be set to "RemoteSigned"

# Get the admin credential
$UserCredential = Get-Credential

# Create the session
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection

# Import the session
Import-PSSession $Session -DisableNameChecking

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

    # Delete existing permissions
    Remove-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess
    Remove-MailboxPermission -Identity $mailbox -User $user -AccessRights SendAs

    Write-Host "Deleted permissions." -ForegroundColor Green

    # Add new permissions
    Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping:$false
    Add-RecipientPermission -Identity $mailbox -Trustee $user -AccessRights SendAs

    Write-Host "New permissions added." -ForegroundColor Green

}
elseif ($option -eq "delete") {
    Write-Host "Option selected:" $option
    Write-Host "User specified:" $user
    Write-Host "Mailbox specified:" $mailbox
    Write-Host "Proceeding with script." -ForegroundColor Green

    # Delete existing permissions
    Remove-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess
    Remove-MailboxPermission -Identity $mailbox -User $user -AccessRights SendAs

    Write-Host "Deleted permissions." -ForegroundColor Green
}
else {
    Write-Host "Unaccepted option:" $option". " -ForegroundColor Red
    Write-Host "Acceptable options are either 'add' or 'delete'. Exiting script."
    Exit
}

# Remove the session
Remove-PSSession $Session


Write-Host "End of script."
