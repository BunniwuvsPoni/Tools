# How to configure permissions for Content Search
Source: https://docs.microsoft.com/en-us/microsoft-365/compliance/permissions-filtering-for-content-search?view=o365-worldwide

## Connect to Security & Compliance PowerShell using MFA and modern authentication
Source: https://docs.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps#connect-to-security--compliance-powershell-using-mfa-and-modern-authentication


### Notes
To specify specific mailboxes, use the following filter:
- Mailbox_PrimarySmtpAddress -eq '(Email)'

To see your compliance security filters:
- Get-ComplianceSecurityFilter | ft FilterName, Action, Users, Filters, IsValid
