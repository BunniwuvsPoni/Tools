# This script exports members of the "All Staff" group including the users Name, Account Status, and Expiration Date
$group = "All Staff"
$export = "(export file path)"

# Exports requested data
Get-ADGroupMember $group | Get-ADUser -Properties * | Sort-Object Name | Select-Object Name, Enabled, AccountExpirationDate | Export-Csv -NoTypeInformation -Path $export
