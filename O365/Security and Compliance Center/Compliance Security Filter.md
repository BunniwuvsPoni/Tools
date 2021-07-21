# How to create a new Compliance Security Filter
1. Connect via PowerShell to the Security and Compliance Center
2. Run the following command
- New-ComplianceSecurityFilter -FilterName <Name> -Users (username)@(domain).(tld) -Filters "Mailbox_PrimarySmtpAddress -eq '(username)@(domain).(tld)'" -Action All

## Notes:
To specify specific mailboxes, use the following filter:
- Mailbox_PrimarySmtpAddress -eq '(email)'
  
To apply to all mailboxes, use the following filter and action:
- Mailbox_PrimarySmtpAddress -eq 'NoPurge@domain.tld'
- Purge

To apply to all SharePoint Online sites, use the following filter:
- Site_Path -eq 'nosites'
  
# How to view Compliance Security Filter
1. Connect via PowerShell to the Security and Compliance Center
2. Run the following command
  - Get-ComplianceSecurityFilter | ft FilterName, Action, Users, Filters, IsValid
