<#
.SYNOPSIS
This script uses USMT to save the specified user to the specified network share.
.DESCRIPTION
This script automates the steps behind saving a specific user profile using USMT.
.PARAMETER Username
.EXAMPLE
& '.\USMT-Save-User.ps1' -Username "username"
.LINK
https://docs.microsoft.com/en-us/windows/deployment/usmt/usmt-scanstate-syntax
#>

# Required parameters to process O365 permissions change
param(
    [Parameter(Mandatory=$true)][string]$Username
    )

# Tests if user profile exists on the C: drive
Test-Path "C:\Users\" $Username

# Fomat current datetime
$Date = Get-Date
$FormattedDate = $Date.ToString("yyyy-mm-dd-hh-mm-ss")

