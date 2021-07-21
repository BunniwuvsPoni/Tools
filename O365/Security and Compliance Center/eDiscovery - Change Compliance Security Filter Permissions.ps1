# This script is intended to add/remove a specific user to/from all Compliance Security Filters in Microsoft 365
# Note: EXO V2 module is required, user must have eDiscovery Manager role in Office 365 Security & Compliance

# Required parameters to modify Compliance Security Filters
param(
    [Parameter(Mandatory=$true)][string]$m365AdminEmail,
    [Parameter(Mandatory=$true)][string]$option,
    [Parameter(Mandatory=$true)][string]$userFirstName,
    [Parameter(Mandatory=$true)][string]$userLastName
)

# Generate user information based on First and Last name details
$username = $userFirstName.Substring(0,1) + $userLastName
$username = $username.ToLower()
$email = $username + "@(domain).(tld)"

# Displays user information
Write-Host 'Email:' $email
Write-Host 'Option:' $option

# Ask for user confirmation
$confirmation = Read-Host "Are You Sure You Want To Proceed (y/n)"
if ($confirmation -eq 'y') {

    # Load the EXO V2 module
    Import-Module ExchangeOnlineManagement

    # Connect to Security & Compliance Center PowerShell in a Microsoft 365 or Microsoft 365 GCC organization
    Connect-IPPSSession -UserPrincipalName $m365AdminEmail

    # Get all Compliance Security Filters
    $filters = Get-ComplianceSecurityFilter

    # Validating option, only add or delete are accepted
    if ($option -eq "add") {
        # Add new permissions
        foreach ($filter in $filters) {
            $filterusers = Get-ComplianceSecurityFilter -FilterName $filter.FilterName
            $filterusers.users.add($email)
            Set-ComplianceSecurityFilter -FilterName $filter.FilterName -Users $filterusers.users
        }

        Write-Host "New permissions added for user:" $email -ForegroundColor Green

    }
    elseif ($option -eq "delete") {
        # Delete existing permissions
        foreach ($filter in $filters) {
            $filterusers = Get-ComplianceSecurityFilter -FilterName $filter.FilterName
            $filterusers.users.remove($email)
            Set-ComplianceSecurityFilter -FilterName $filter.FilterName -Users $filterusers.users
        }

        Write-Host "Deleted permissions for user:" $email -ForegroundColor Green
    }
    else {
        Write-Host "Unaccepted option:" $option". " -ForegroundColor Red
        Write-Host "Acceptable options are either 'add' or 'delete'. Exiting script."
        Exit
    }

    # Display updated Compliance Security Filters
    Get-ComplianceSecurityFilter | ft FilterName, Action, Users, Filters, IsValid

} else {
    Write-Host 'Change Compliance Security Filter Permissions process cancelled.'
}
