# How to create a new Compliance Security Filter
1. Connect via PowerShell to the Security and Compliance Center
2. Run the following command
- New-ComplianceSecurityFilter -FilterName <Name> -Users (username)@(domain).(tld) -Filters "Mailbox_PrimarySmtpAddress -eq '(username)@(domain).(tld)'" -Action All

# How to view Compliance Security Filter
1. Connect via PowerShell to the Security and Compliance Center
2. Run the following command
  - Get-ComplianceSecurityFilter | ft FilterName, Action, Users, Filters, IsValid
