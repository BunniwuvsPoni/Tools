# Note: Script must be run as an administrator on the DC

# Required parameters to add new Active Directory user
param(
    [Parameter(Mandatory=$true)][string]$firstName,
    [Parameter(Mandatory=$true)][string]$lastName,
    [Parameter(Mandatory=$true)][string]$password,
    [Parameter(Mandatory=$true)][string]$emailExternal
)

# Configurable AD fields
$organizationalUnit = "OU=<ou>,DC=<domain>,DC=<tld>"
$group = "<Desired group>"
$jobTitle = "<Job title>"
$description = "External SharePoint User"

# Generate user information based on First and Last name details
$displayName = $firstName + " " + $lastName
$username = $firstName.Substring(0,1) + $lastName
$username = $username.ToLower()
$email = $username + "@<domain>.<tld>"

# Convert plain text password to secure string
$password = ConvertTo-SecureString $password -AsPlainText -Force

# Displays user information
Write-Host 'Username:' $username
Write-Host 'Email:' $email

# Ask for user confirmation
$confirmation = Read-Host "Are You Sure You Want To Proceed (y/n)"
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
    -PasswordNeverExpires $true `
    -Path $organizationalUnit `
    -DisplayName $displayName `
    -EmailAddress $emailExternal `
    -Title $jobTitle `
    -Description $description

    # Add new user to group
    Add-ADGroupMember -Identity $group -Members $username

    # Enable new AD user
    Enable-ADAccount $username

    Write-Host 'User created:' $username
} else {
    Write-Host 'User creation process cancelled.'
}
