<#
.SYNOPSIS
This script returns your name as a console output
.DESCRIPTION
This is a powershell script that is designed to return your name (string output)
.PARAMETER Name
Your name
.EXAMPLE
& '.\Hello World.ps1' -Name "Your Name"
.LINK
www.google.ca
#>

#param() sets the required/optional parameters that this powershell script accepts
param(
    #[Parameter(Mandatory=$true)] forces the parameter [string]$Name to be required
    [Parameter(Mandatory=$true)][string]$Name
)

#Write-Host writes content out to the console
#-NoNewLine is the optional argument that tells powershell not to automatically create a new line
Write-Host "Hello World!"
Write-Host -NoNewLine "Your name is: "
Write-Host -NoNewLine $Name