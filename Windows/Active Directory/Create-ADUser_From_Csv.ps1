<#
.SYNOPSIS
Creates AD users from .csv file.
.DESCRIPTION
This script creates Active Directory users from the specified .csv file.
Notes:
- Run this script as an Administrator on your Domain Controller to create AD users
- Required data from .csv: First Name, Last Name, Username, Email, Password (including column header with spaces for the names)
- ExecutionPolicy should be set to "RemoteSigned"
.PARAMETER File
.csv file location
.EXAMPLE
& '.\Create-ADUser_from_Csv.ps1' -File '.\<File>.csv'
.LINK
https://docs.microsoft.com/en-us/powershell/module/addsadministration/new-aduser?view=win10-ps
#>

# Required parameters to process O365 permissions change
param(
    [Parameter(Mandatory=$true)][string]$File
    )

# Checks if the file exists
if ([System.IO.File]::Exists($File) -eq $False) {
    Write-Host "File does not exist, exiting script..."
    Exit
}

# Imports .csv
$imports = Import-Csv $File

# Imports AD module
Import-Module ActiveDirectory

ForEach ($import in $imports) {
    $DisplayName = $import.'First Name' + " " + $import.'Last Name'
    $Username = $import.Username + "@<domain>.<tld>"
    $Description = "<Insert description here if required>"

    New-ADUser `
    -Description $Description `
    -GivenName $import.'First Name' `
    -Surname $import.'Last Name' `
    -EmailAddress $import.Email `
    -SAMAccountName $import.Username `
    -UserPrincipalName $Username `
    -DisplayName $DisplayName `
    -Name $DisplayName `
    -AccountPassword (ConvertTo-SecureString $import.Password -AsPlainText -Force) `
    -PasswordNeverExpires $true

    Write-Host 'User created:' $import.Username
}
