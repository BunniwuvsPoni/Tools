# This script exports all computers from Active Directory

# Export path
$path = (file path)
$path = $path + "Computers.csv"

# Get computes and export to path
Get-ADComputer -Filter * -Property * | Select-Object Name,OperatingSystem,OperatingSystemVersion,ipv4Address | Export-CSV $path-NoTypeInformation -Encoding UTF8
