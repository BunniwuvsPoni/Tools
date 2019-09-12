Add-PSSnapin Microsoft.Sharepoint.Powershell

# Note: You may have to update permissions in SharePoint Central Administrations for the update to be accepted, this script runs as an Admin of the SharePoint environment from the Sharepoint Server.

# Log file path
$desktoppathlog = [Environment]::GetFolderPath("Desktop") + "\SharePoint Permissions Export Log.txt"

# Export csv file path
$dateexportcsv = Get-Date -format "MM-dd-yyyy-hh-mm-ss"
$desktoppathcsv = [Environment]::GetFolderPath("Desktop") + "\" + $dateexportcsv + " - SharePoint Permissions Export.csv"

# Log date and time of initiation
date | Tee-Object -FilePath $desktoppathlog -Append

# Log start message
Write-Output "Start export" | Tee-Object -FilePath $desktoppathlog -Append

# Initializing local variables
$permissions = @()
$dateexported = date

# Connects to the local SharePoint server to retrieve url list
$webapp = Get-SPWebApplication

# Loop through each URL
foreach($url in $webapp.Sites.Url)
{
    Write-Output $url

    # Connects to the specified SharePoint Site
    $sites = Get-SPSite($url)

    # Loop through each site in URL
    foreach($site in $sites.AllWebs)
    {
        Write-Output $site.Title

        # Loop through each permission group
        foreach($group in $site.Groups)
        {
            Write-Output $group.Name
            
            # Add each user found for export    
            foreach($user in $group.Users)
            {
                Write-Output $user.UserLogin
                Write-Output $user.DisplayName
                Write-Output $user.Email

                $permission = New-Object System.Object
                $permission | Add-Member -MemberType NoteProperty -Name "DateExported" -Value $dateexported
                $permission | Add-Member -MemberType NoteProperty -Name "URL" -Value $url
                $permission | Add-Member -MemberType NoteProperty -Name "SiteURL" -Value $site.Url
                $permission | Add-Member -MemberType NoteProperty -Name "Site" -Value $site.Title
                $permission | Add-Member -MemberType NoteProperty -Name "Group" -Value $group.Name
                $permission | Add-Member -MemberType NoteProperty -Name "UserLogin" -Value $user.UserLogin
                $permission | Add-Member -MemberType NoteProperty -Name "UserDisplayName" -Value $user.DisplayName
                $permission | Add-Member -MemberType NoteProperty -Name "UserEmail" -Value $user.Email

                $permissions += $permission
            }
        }
    }
}

# Export to csv
$permissions | Export-Csv -Path $desktoppathcsv -Append -NoTypeInformation


# Log date and time of completion
date | Tee-Object -FilePath $desktoppathlog -Append

# Log end message
Write-Output "End of export" | Tee-Object -FilePath $desktoppathlog -Append
