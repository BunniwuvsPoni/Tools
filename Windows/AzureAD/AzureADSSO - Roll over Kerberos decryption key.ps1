# AzureAD PowerShell must be installed
# Must be ran in administrative PowerShell
# Must have Microsoft 365 Global Administrator account
# Must have Active Directory Domain Administrator account
# Note: Ensure that you don't run the Update-AzureADSSOForest command more than once. Otherwise, the feature stops working until the time your users' Kerberos tickets expire and are reissued by your on-premises Active Directory.

# Naviage to Azure AD Connect directory and import AzureADSSO PowerShell
cd "C:\Program Files\Microsoft Azure Active Directory Connect"
Import-Module .\AzureADSSO.psd1

# Get list of AD forests with SSO enabled
New-AzureADSSOAuthenticationContext
Get-AzureADSSOStatus | ConvertFrom-Json

# Roll over Kereberos decryption key
$creds = Get-Credential
Update-AzureADSSOForest -OnPremCredentials $creds
