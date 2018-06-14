#This script forces a Windows Update scan, this is useful if you are unable to check for Windows Updates due to updates being installed etc.
$AutoUpdates = New-Object -ComObject "Microsoft.Update.AutoUpdate"
$AutoUpdates.DetectNow()