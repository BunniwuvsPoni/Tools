# PowerShell Arrays

# One dimension array
$singleArrayNumber = @(1, 2, 3, 4, 5)
$singleArrayText = @("A", "B", "C", "D", "E")

Write-Host "Print array"
$singleArrayNumber
$singleArrayText

Write-Host "Print selection of single dimension array"
$singleArrayNumber[2]
$singleArrayText[2]

# Two dimension array
$2dArray = New-Object 'object[,]' 3,2
$2dArray[0,0] = "A"
$2dArray[0,1] = 1
$2dArray[1,0] = "B"
$2dArray[1,1] = 2
$2dArray[2,0] = "C"
$2dArray[2,1] = 3

Write-Host "Print selection of two dimension array"
$2dArray[0,0]
$2dArray[2,1]


# Export to .csv
# Setup data
$columns = @("ID", "Number", "Letter")
$array1 = @(0, 123, "ABC")
$array2 = @(1, 999, "ZZZ")

# Setup export variable
$csvExport = @()

# Add values
$csvExportObject = New-Object PSObject
$csvExportObject | Add-Member -MemberType NoteProperty -Name $columns[0] -Value $array1[0]
$csvExportObject | Add-Member -MemberType NoteProperty -Name $columns[1] -Value $array1[1]
$csvExportObject | Add-Member -MemberType NoteProperty -Name $columns[2] -Value $array1[2]
$csvExport += $csvExportObject
$csvExportObject = $null

$csvExportObject = New-Object PSObject
$csvExportObject | Add-Member -MemberType NoteProperty -Name $columns[0] -Value $array2[0]
$csvExportObject | Add-Member -MemberType NoteProperty -Name $columns[1] -Value $array2[1]
$csvExportObject | Add-Member -MemberType NoteProperty -Name $columns[2] -Value $array2[2]
$csvExport += $csvExportObject
$csvExportObject = $null

# Print out the .csv export
$csvExport | ConvertTo-Csv -NoTypeInformation
