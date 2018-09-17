# User to be removed from SharePoint environment
param(
    [Parameter(Mandatory=$true)][string]$name
)

Add-PSSnapin Microsoft.Sharepoint.Powershell

# Note: You may have to update permissions in SharePoint Central Administrations for the update to be accepted, this script runs as an Admin of the SharePoint environment from the Sharepoint Server.

# Log file path
$desktoppath = [Environment]::GetFolderPath("Desktop") + "\SharePoint Delete Log.txt"

# Confirmation of username to be deleted
$user = "i:0#.w|ndeb\$name"

echo "Please confirm that $user is the user you wish to delete from all SharePoint environments. (y/n)" | Tee-Object -FilePath $desktoppath -Append

$readhost = Read-Host " ( y / n) "

if($readhost = y){

    # Log selection
    echo "User accepted $user, continuing function." | Tee-Object -FilePath $desktoppath -Append

    # Connects to the local SharePoint server to retrieve url list
    $webapp = Get-SPWebApplication

    foreach ($url in $webapp.sites.url){
    
        date | Tee-Object -FilePath $desktoppath -Append

        echo $url | Tee-Object -FilePath $desktoppath -Append

        echo $user | Tee-Object -FilePath $desktoppath -Append

        Remove-SPUser -Identity $user - Web $url
    }

} else {

    # Log selection
    echo "User did not accept $user, closing function." | Tee-Object -FilePath $desktoppath -Append

}
