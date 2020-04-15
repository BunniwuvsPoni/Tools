# This script is intended to export the group permissions from a specific SharePoint Online Site
# Note: This script requires SharePoint Online Powershell to work

# SPO Domain is specified here
$Domain = "<insert domain here>"

# SPO Site Url is specified here
$URL = "https://" + $Domain + ".sharepoint.com/sites/<insert site here>"

# Log file path
$DesktopPathLog = [Environment]::GetFolderPath("Desktop") + "\SharePoint Online Permissions Export Log.txt"

# Export csv file path
$ExportCsvPath = [Environment]::GetFolderPath("Desktop") + "\SPO Permissions Export.csv"

# SPO Admin Url
$SPOUrl = "https://" + $Domain + "-admin.sharepoint.com"

# Deletes existing export file since we do not want duplicate data
if (Test-Path $ExportCsvPath) 
{
  Remove-Item $ExportCsvPath
}

# Log date and time of initiation
date | Tee-Object -FilePath $DesktopPathLog -Append

# Log start message
Write-Output "Start export" | Tee-Object -FilePath $DesktopPathLog -Append

# Initializing local variables
$Permissions = @()
$DateExported = date

# Connects to SharePoint Online server
Connect-SPOService -Url $SPOUrl

Write-Output ($URL + " - Started") | Tee-Object -FilePath $DesktopPathLog -Append
    
# Export groups from SPOSite
$Groups = Get-SPOSiteGroup -Site $URL

foreach($Group in $Groups)
{
    $UsersInGroup = Get-SPOUser -Site $URL -Group $Group.LoginName

    foreach($UserInGroup in $UsersInGroup)
    {
        Write-Output $UserInGroup.LoginName

        $Permission = New-Object System.Object
        $Permission | Add-Member -MemberType NoteProperty -Name "DateExported" -Value $DateExported
        $Permission | Add-Member -MemberType NoteProperty -Name "SiteURL" -Value $URL
        $Permission | Add-Member -MemberType NoteProperty -Name "Group" -Value $Group.LoginName
        $Permission | Add-Member -MemberType NoteProperty -Name "UserLogin" -Value $UserInGroup.LoginName
        $Permission | Add-Member -MemberType NoteProperty -Name "UserDisplayName" -Value $UserInGroup.DisplayName

        $Permissions += $Permission
    }
}

Write-Output ($URL.Url + " - Exported") | Tee-Object -FilePath $DesktopPathLog -Append

# Export to csv
$Permissions | Export-Csv -Path $ExportCsvPath -Append -NoTypeInformation


# Log date and time of completion
date | Tee-Object -FilePath $DesktopPathLog -Append

# Log end message
Write-Output "End of export" | Tee-Object -FilePath $DesktopPathLog -Append
