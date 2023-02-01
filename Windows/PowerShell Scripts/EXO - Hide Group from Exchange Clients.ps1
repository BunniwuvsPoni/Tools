# This script is intended to hide Microsoft 365 group from the address list and the member's calendar
# Required parameters to process Exchange Online permissions change
param(
    [Parameter(Mandatory=$true)][string]$group
)


# Confirmation of settings
echo "Please confirm that $group will be hidden from all Exchange Online Clients. (y/n)"

$readhost = Read-Host "(y / n)"

if($readhost -eq 'n'){
    echo "User did not accept, closing function."
    Exit
}

# Connecting to O365 Exchange Online PowerShell V2
# Find the local installation of Exchange Online PowerShell V2 Module
$exchangeonlinepowershellinstalled = Get-InstalledModule -Name "ExchangeOnlineManagement"

# Check if Exchange Online Powershell Module V2 exists
if ($exchangeonlinepowershellinstalled -eq $null) {
    Write-Host "Exchange Online PowerShell Module V2 is not installed, exiting script." -ForegroundColor Red
    Exit
}
else {
    Write-Host "Exchange Online PowerShell Module V2 is installed, proceeding with script." -ForegroundColor Green
}

# Create the session (need to provide administrator username and password)
Connect-ExchangeOnline

# Check if the group exists in Exchange Online
$groupCheck = Get-UnifiedGroup $group -ErrorAction SilentlyContinue | Format-List -Property PrimarySmtpAddress

if ($groupCheck) {
    Write-Host "Group:" $group "exists. Proceeding with script." -ForegroundColor Green
}
else {
    Write-Host "Group:" $group "does not exist. Exiting script." -ForegroundColor Red
    Exit
}

# Set -HiddenFromExchangeClientsEnabled switch
Set-UnifiedGroup $group -HiddenFromExchangeClientsEnabled

# Display updated changes
Get-UnifiedGroup $group | Format-List -Property HiddenFromExchangeClientsEnabled, HiddenFromAddressListsEnabled

# Remove all PowerShell Sessions
Get-PSSession | Remove-PSSession

# End of script
Write-Host "End of script."
[void](Read-Host 'Press Enter to continue…')
