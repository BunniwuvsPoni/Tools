Add-PSSnapin Microsoft.Sharepoint.Powershell

# Note: You may have to update permissions in SharePoint Central Administrations for the update to be accepted, this script runs as an Admin of the SharePoint environment from the Sharepoint Server.

# Log file path
$desktoppath = [Environment]::GetFolderPath("Desktop") + "\SharePoint Sync Log.txt"

foreach ($url in $webapp.sites.url){
    
    date | Tee-Object -FilePath $desktoppath -Append

    echo $url | Tee-Object -FilePath $desktoppath -Append

    # Display the existing Email
    $users = Get-SPUser -Web $url
    $users | Select UserLogin,DisplayName,Email | Tee-Object -FilePath $desktoppath -Append


    foreach ($user in $users) {

        echo $user.UserLogin | Tee-Object -FilePath $desktoppath -Append

        if($user.UserLogin.StartsWith("i")) {
        
            # Syncs the user profile with Active Directory if the username begins with an "i"
            Set-SPUser -Identity $user.UserLogin -Web $url -SyncFromAD

        }

    }

    # Display updated email
    $users = Get-SPUser -Web $url
    $users | Select UserLogin,DisplayName,Email | Tee-Object -FilePath $desktoppath -Append
}