<#
.SYNOPSIS
Add Full Access/Send As permissions in O365
.DESCRIPTION
This script is designed to connect to O365 Outlook and add user permissions: Full Access (no automapping) and Send As permissions on a mailbox from a .csv
Note: ExecutionPolicy should be set to "RemoteSigned"
Last updated: 02/28/2020 - Updated to use Exchange Online PowerShell V2
.PARAMETER file
Import .csv file with EXO permissions to add, 2 columns, Mailbox followed by User
.EXAMPLE
& '.\EXO2020MP.ps1' -file "<file>"
.LINK
https://support.microsoft.com/en-ca/help/2646504/how-to-remove-automapping-for-a-shared-mailbox-in-office-365
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online/exchange-online-powershell-v2/exchange-online-powershell-v2?view=exchange-ps
#>

# Required parameters to process O365 permissions change
param(
    [Parameter(Mandatory=$true)][string]$file
)

# Import permissions from .csv
$imports = Import-Csv $file

# Add domain to user/mailbox
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

foreach ($import in $imports) {
    # Validates user/mailbox is a full mailbox by searching for the "@" symbol
    $user = $import.user
    $mailbox = $import.mailbox

    if(!($user -match "@")) {
        $user = $user + $domain
    }

    if(!($mailbox -match "@")) {
        $mailbox = $mailbox + $domain
    }

    # Check if the user exists in O365
    $userCheck = Get-EXOMailbox -Identity $user -ErrorAction SilentlyContinue | Format-List -Property PrimarySmtpAddress

    if ($userCheck) {
        Write-Host "User:" $user "exists. Proceeding with script." -ForegroundColor Green
    }
    else {
        Write-Host "User:" $user "does not exist. Exiting script." -ForegroundColor Red
        Exit
    }

    # Check if the mailbox exists in O365
    $mailboxCheck = Get-EXOMailbox -Identity $mailbox -ErrorAction SilentlyContinue | Format-List -Property PrimarySmtpAddress

    if ($mailboxCheck) {
        Write-Host "Mailbox:" $mailbox "exists. Proceeding with script." -ForegroundColor Green
    }
    else {
        Write-Host "Mailbox:" $mailbox "does not exist. Exiting script." -ForegroundColor Red
        Exit
    }

    # Add Full Access and Send As permissions
    Write-Host "User specified:" $user
    Write-Host "Mailbox specified:" $mailbox
    Write-Host "Proceeding with script." -ForegroundColor Green

    # Add new permissions
    Add-MailboxPermission -Identity $mailbox -User $user -AccessRights FullAccess -AutoMapping:$false
    Add-RecipientPermission -Identity $mailbox -Trustee $user -AccessRights SendAs -Confirm:$false

    Write-Host "New permissions added." -ForegroundColor Green

}
# Remove all PowerShell Sessions
Get-PSSession | Remove-PSSession

# End of script
Write-Host "End of script."
[void](Read-Host 'Press Enter to continue…')
