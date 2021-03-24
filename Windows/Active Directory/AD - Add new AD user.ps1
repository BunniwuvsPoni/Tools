# Note: Script must be run as an administrator on the DC

# Required parameters to add new Active Directory user
param(
    [Parameter(Mandatory=$true)][string]$firstName,
    [Parameter(Mandatory=$true)][string]$lastName
)

# Configurable AD fields
$password = "<Default password>"
$organizationalUnit = "OU=<ou>,DC=<domain>,DC=<tld>"
$group = "<Desired group>"
$office = "<Office>"
$homePage = "<Website>"
$officePhone = "<Office phone>"
$company = "<Company name>"
$streetAddress = "<Address>"
$city = "<City>"
$state = "<State>"
$postalCode = "<Postal code>"
$country = "<Country code>"
$description = "Domain user."

# Generate user information based on First and Last name details
$displayName = $firstName + " " + $lastName
$username = $firstName.Substring(0,1) + $lastName
$username = $username.ToLower()
$email = $username + "@<domain>.<tld>"
$proxyAddresses = "SMTP:" + $username + "@<domain>.<tld>"
$proxyAddresses = $proxyAddresses + "," + "smtp:" + $username + "@<domain>.<tld>"
$proxyAddresses = $proxyAddresses + "," + "smtp:" + $username + "@<domain>.<tld>"
$proxyAddresses = $proxyAddresses + "," + "smtp:" + $username + "@<domain>.<tld>"
$proxyAddresses = $proxyAddresses + "," + "smtp:" + $username + "@<domain>.onmicrosoft.com"

# Convert plain text password to secure string
$password = ConvertTo-SecureString $password -AsPlainText -Force

# Displays user information
Write-Host 'Username:' $username
Write-Host 'Email:' $email

# Ask for user confirmation
$confirmation = Read-Host "Are you Sure You Want To Proceed (y/n)"
if ($confirmation -eq 'y') {

    # Imports AD module
    Import-Module ActiveDirectory

    # Creates new AD user
    New-ADUser `
    -GivenName $firstName `
    -Surname $lastName `
    -Name $displayName `
    -UserPrincipalName $email `
    -SAMAccountName $username `
    -AccountPassword $password `
    -Path $organizationalUnit `
    -DisplayName $displayName `
    -Office $office `
    -EmailAddress $email `
    -HomePage $homePage `
    -OfficePhone $officePhone `
    -Company $company `
    -StreetAddress $streetAddress `
    -City $city `
    -State $state `
    -PostalCode $postalCode `
    -Country $country `
    -Description $description

    # Sets new AD user properties
    Set-ADUser $username -replace @{ProxyAddresses=$proxyAddresses -split ","}

    # Add new user to group
    Add-ADGroupMember -Identity $group -Members $username

    # Enable new AD user
    Enable-ADAccount $username
    
    Write-Host 'User created:' $username
} else {
    Write-Host 'User creation process cancelled.'
}
