# This script is intended to copy files from directory x to y and remove files after the specified retention period

# Specify the source and destination directories
$source = "(source)"
$destination = "(destination)"

# Specify the retention periods in days
$destinationRetention = 365

# Log file
$log = "C:\Users\(user)\Desktop\Log.txt"

# Log initialization
$dateStarted = date
Write-Output "Archive copy started: " $dateStarted | Tee-Object -FilePath $log -Append

# Robocopy file copy, delete $source files when done
Robocopy.exe $source $destination /e | Tee-Object -FilePath $log -Append
Write-Output "Starting deletion of source files." | Tee-Object -FilePath $log -Append
Get-ChildItem -Path $source | Remove-Item -Recurse -Force -Confirm:$false
Write-Output "Source files deleted." | Tee-Object -FilePath $log -Append

# Delete files older than $destinationRetention days in $destination
Write-Output "Deleting the following files that are older than (x) day(s) " $destinationRetention | Tee-Object -FilePath $log -Append
Get-ChildItem -Path $destination -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-$destinationRetention))} | Tee-Object -FilePath $log -Append
Get-ChildItem -Path $destination -Recurse | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-$destinationRetention))} | Remove-Item
Write-Output "Files, if any, deleted." | Tee-Object -FilePath $log -Append


# Log completion
$dateEnded = date
Write-Output "Archive copy ended:" $dateEnded | Tee-Object -FilePath $log -Append
