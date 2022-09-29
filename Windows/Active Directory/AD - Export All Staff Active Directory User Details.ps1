# Exports Active Directory Group Member Details

# Variables
$group = "All Staff"
$exportPath = "$env:USERPROFILE\Desktop\$group.csv"
$header = """GivenName"",""Surname"",""Title"",""Manager"""

# Export user details
$header | Tee $exportPath -Append

# Get group members
Get-ADGroupMember -Identity $group | Sort-Object Name | ForEach-Object {
         # Get user details
         Get-ADUser -Identity $_.SamAccountName -Properties Title | 
         # Select properties, search for manager display name
         Select-Object -Property GivenName, Surname, Title, @{Name='Manager';Expression={(($_ |Get-ADUser -Properties manager).manager | Get-ADUser).Name}} |
         # Convert to Csv format
         ConvertTo-Csv -NoTypeInformation |
         # Skip header
         Select-Object -Skip 1 |
         # Export to file
         Tee $exportPath -Append
     }
