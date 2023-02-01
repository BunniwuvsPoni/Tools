# This powershell script is intended to set all user type mailboxes in Exchange Online to enable 1) Archiving and 2) Litigation Hold
# Please note, you need to install Exchange Online Powershell for this to work

# Connecting to Microsoft 365 Exchange Online PowerShell
# Find the local installation of Exchange Online PowerShell Module
$exchangeonlinepowershellinstalled = Get-InstalledModule -Name "ExchangeOnlineManagement"

# Check if Exchange Online Powershell Module exists
if ($exchangeonlinepowershellinstalled -eq $null) {
    Write-Host "Exchange Online PowerShell Module is not installed, exiting script." -ForegroundColor Red
    Exit
}
else {
    Write-Host "Exchange Online PowerShell Module is installed, proceeding with script." -ForegroundColor Green
}

# Create the session (need to provide administrator username and password)
Connect-ExchangeOnline

# Enable Archiving
Get-Mailbox -Filter {RecipientTypeDetails -eq "UserMailbox"} | Enable-Mailbox -Archive

# Enable Litigation Hold
Get-Mailbox -Filter {RecipientTypeDetails -eq "UserMailbox"} | Set-Mailbox -LitigationHoldEnabled $true

# Display the results
Get-Mailbox -Filter {RecipientTypeDetails -eq "UserMailbox"} | Sort-Object PrimarySmtpAddress | ft Name, Alias, PrimarySmtpAddress, ArchiveStatus, LitigationHoldEnabled
