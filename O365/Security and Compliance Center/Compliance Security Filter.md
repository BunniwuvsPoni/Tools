# How to create a new Compliance Security Filter
1. Connect via PowerShell to the Security and Compliance Center
2. Run the following command
- New-ComplianceSecurityFilter -FilterName <Name> -Users (username)@(domain).(tld) -Filters "Mailbox_PrimarySmtpAddress -eq '(username)@(domain).(tld)'" -Action All

## Notes:
To specify specific mailboxes, use the following filter:
- Mailbox_PrimarySmtpAddress -eq '(email)'
  
*By creating filters, you are implicilty excluding all other data sources...
- To restrict "All", include Exchange Online (NoSearch@domain.tld) and SharePoint Online (NoSites) Filters  

To disable purge for all mailboxes, use the following filter and action:
- Mailbox_PrimarySmtpAddress -eq 'NoPurge@domain.tld'
- Purge

To disable all SharePoint Online sites, use the following filter and action:
- Site_Path -eq 'NoSites'
- All

You can use search permissions filtering to let an eDiscovery manager search only a subset of mailboxes and sites in your organization. You can also use permissions filtering to let that same eDiscovery manager search only for mailbox or site content that meets a specific search criteria. For example, you might let an eDiscovery manager search only the mailboxes of users in a specific location or department. You do this by creating a filter that uses a supported recipient filter to limit which mailboxes a specific user or group of users can search.
Source:
- https://docs.microsoft.com/en-us/microsoft-365/compliance/permissions-filtering-for-content-search?view=o365-worldwide
- https://docs.microsoft.com/en-us/powershell/module/exchange/new-compliancesecurityfilter?view=exchange-ps
  
# How to view Compliance Security Filter
1. Connect via PowerShell to the Security and Compliance Center
2. Run the following command
  - Get-ComplianceSecurityFilter | ft FilterName, Action, Users, Filters, IsValid
