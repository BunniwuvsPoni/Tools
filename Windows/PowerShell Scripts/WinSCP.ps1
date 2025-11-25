# This script is intended to use WinSCP Command Line Interface to Upload File(s) and Folder(s) to a FTP(S) Server.

# FTP Parameters
param(
    # Can Upload File(s) and Folder(s)
    [Parameter(Mandatory=$true)]
    [string]$sourceData,
    [Parameter(Mandatory=$true)]
    [string]$ftpPassword,
    [string]$targetDirectory = 'WinSCP\Upload\',
    [string]$ftpUsername = '',
    [string]$ftpHost = '',
    [string]$ftpPort = '',
    [string]$ftpCertificate = ''
)
 
# Generate Globally Unique Identifier (GUID) for Target Directory
$GUID = [guid]::NewGuid()
if ($targetDirectory.EndsWith("\")) {
    $targetDirectory = $targetDirectory + $GUID
} else {
    $targetDirectory = $targetDirectory + '\' + $GUID
}
 
# FTP Protocol
$ftpProtocol = 'ftpes'
 
# Path to WinSCP.com
$WinSCP = 'C:\Program Files (x86)\WinSCP\WinSCP.com'
 
# Path to WinSCP Log File
$WinSCPLog = 'C:\TEMP\WinSCP\Log\WinSCP.log'
# Check if the WinSCP Log File Exists
if (-not (Test-Path -Path $WinSCPLog)) {
    # Create the WinSCP Log File and Path if it doesn't exist
    New-Item -Path $WinSCPLog -ItemType File -Force
    Write-Host "WinSCP Log File created successfully."
} else {
    Write-Host "The WinSCP Log File already exists."
}
 
# Add Transfer Details to WinSCP Log File
$date = Get-Date
$utcDate = $date.ToUniversalTime()
Add-Content -Path $WinSCPLog -Value 'Date Time (UTC):'
Add-Content -Path $WinSCPLog -Value $utcDate
Add-Content -Path $WinSCPLog -Value 'Source:'
Add-Content -Path $WinSCPLog -Value $sourceData
Add-Content -Path $WinSCPLog -Value 'Target:'
Add-Content -Path $WinSCPLog -Value $targetDirectory
 
# Needed for PowerShell 7.3 and newer
$PSNativeCommandArgumentPassing = "Legacy"
 
# Commands List = https://winscp.net/eng/docs/scripting#commands
    # Open Connection Command
    $WinSCPOpen = "open " + $ftpProtocol + "://" + $ftpUsername + ":" + [System.Uri]::EscapeDataString($ftpPassword) + "@" + $ftpHost + ":" + $ftpPort +"/ -certificate=`"`"" + $ftpCertificate +"`"`""
    # Make Directory Command
    $WinSCPCreateDirectory = "mkdir `"`"" + $targetDirectory +"`"`""
    # Move to Directory Command
    $WinSCPMoveDirectory = "cd `"`"" + $targetDirectory +"`"`""
    # Upload Command
    $WinSCPUpload = "put `"`"" + $sourceData +"`"`""
 
& $WinSCP `
  /log="$WinSCPLog" /ini=nul `
  /command `
    $WinSCPOpen `
    $WinSCPCreateDirectory `
    $WinSCPMoveDirectory `
    $WinSCPUpload `
    "exit"
 
# Error Reporting
$WinSCPResult = $LastExitCode
if ($WinSCPResult -eq 0)
{
  Write-Host "Success"
}
else
{
  Write-Host "Error"
}
 
exit $WinSCPResult
