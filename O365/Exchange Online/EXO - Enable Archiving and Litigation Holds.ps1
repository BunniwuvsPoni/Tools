# This powershell script is intended to set all user type mailboxes in Exchange Online to enable 1) Archiving and 2) Litigation Hold
# Please note, you need to install Exchange Online Powershell V2 for this to work

# Connect to Exchange Online
Connect-ExchangeOnline

# Enable Archiving
Get-Mailbox -Filter {RecipientTypeDetails -eq "UserMailbox"} | Enable-Mailbox -Archive

# Enable Litigation Hold
Get-Mailbox -Filter {RecipientTypeDetails -eq "UserMailbox"} | Set-Mailbox -LitigationHoldEnabled $true

# Display the results
Get-Mailbox -Filter {RecipientTypeDetails -eq "UserMailbox"} | ft Name, Alias, PrimarySmtpAddress, ArchiveStatus, LitigationHoldEnabled
