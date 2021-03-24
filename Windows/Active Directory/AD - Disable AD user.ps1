# Note: Script must be run as an administrator on the DC

# Required parameters to disable Active Directory user
param(
    [Parameter(Mandatory=$true)][string]$firstName,
    [Parameter(Mandatory=$true)][string]$lastName,
    [Parameter(Mandatory=$true)][string]$password
)

# Configurable variables
$inactiveOrganizationalUnit = "OU=<ou>,DC=<domain>,DC=<tld>"

# Generate username
$username = $firstName.Substring(0,1) + $lastName
$username = $username.ToLower()

# Convert plain text password to secure string
$password = ConvertTo-SecureString $password -AsPlainText -Force

# Displays user information
Write-Host 'Username:' $username

# Ask for user confirmation
$confirmation = Read-Host "Are You Sure You Want To Proceed (y/n)"
if ($confirmation -eq 'y') {

    # Imports AD module
    Import-Module ActiveDirectory

    # Change AD user password
    Set-ADAccountPassword -Identity $username -NewPassword $password -Reset
    
    # Sets AD user properties
    Set-ADUser $username -replace @{msExchHideFromAddressLists=$true}

    # Removes all group memberships
    Get-ADGroup -Filter * | Remove-ADGroupMember -Members $username -Confirm:$false

    # Removes Job title, Department, Company, and Manager
    Set-ADUser $username -Title $null -Department $null -Company $null -Manager $null

    # Move user to designated inactive organizational unit
    Get-ADUser $username | Move-ADObject -TargetPath $inactiveOrganizationalUnit

    Write-Host 'User disabled:' $username
} else {
    Write-Host 'User disable process cancelled.'
}
