### This powershell script is designed to clean out the "<File path to folder>" directory based on "<negative # of days>"
## i.e. Replace "File path to folder" with "C:\Users\<Username>\Downloads\" and "negative # of days" with -7 to remove downloads older than 7 days
## Get-ChildItem –Path "C:\Users\<Username>\Downloads\" -Recurse | Where-Object {!$_.PSIsContainer} | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item
## powershell.exe -ExecutionPolicy Bypass "File path to powershell script".ps1

# Log file path
$desktoppath = [Environment]::GetFolderPath("Desktop") + "\Automatic Cleanup Log.txt"

Get-ChildItem –Path "<File path to folder>" -Recurse | Where-Object {!$_.PSIsContainer} | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays("<negative # of days>"))} | Remove-Item

# Log current date and time
$date = date

# Log automatic clean up run
echo "$date - Completed automatic cleanup!" | Tee-Object -FilePath $desktoppath -Append
