# Administrator access is only required if you have the postgres server hosted on a seperate computer
#Requires -RunAsAdministrator

# This script is intended to import a postgresql database into a postgresql instance and export all of the tables
# How to use this script
# Command: Start-Process PowerShell.exe -ArgumentList '-File "\\<server>\<path to this script>\Initial_Script.ps1" -importFilePath "\\<server>\<path to sql dump>.sql"' -Verb runAs
# Note this is a two part script, you will need this script in addition to Local_Import.ps1

#region requiredVariables
# Requires import file parameter
param(
    [Parameter(Mandatory=$true)][string]$importFilePath
)

# Script variables
$scriptFileName = "Local_Import.ps1"
$fileDir = "postgres"
$remoteServer = "<remote server name>"
$exportServer = "<export server path>"


# Generated paths
$importFileName = Split-Path $importFilePath -leaf
$scriptFilePath = $exportServer + "scripts\" + $scriptFileName
$remotePath = "\\" + $remoteServer + "\c$\" + $fileDir + "\"
$exportPath = $exportServer + $fileDir + "\"
#endregion requiredVariables

#region testsImportFileAndDirectories
# Checks to make sure the import and script files exists
# If the import file does not exist, removes export directory, and exit the script
if(![System.IO.File]::Exists($importFilePath) -Or ![System.IO.File]::Exists($scriptFilePath))
{
    rmdir $exportPath -Recurse
    exit
}

# Creates the remote directory if not exists, if exists the script will recreate the directory
if(![System.IO.Directory]::Exists($remotePath))
{
    mkdir $remotePath
} else {
    rmdir $remotePath -Recurse
    mkdir $remotePath
}

# Creates the export directory if not exists, if exists the script will recreate the directory
if(![System.IO.Directory]::Exists($exportPath))
{
    mkdir $exportPath
} else {
    rmdir $exportPath -Recurse
    mkdir $exportPath
}
#endregion testsImportFileAndDirectories

#region copyFiletoRemoteServer
# Copy import sql file over to the remote server
Copy-Item $importFilePath ($remotePath + $importFileName)
#endregion copyFiletoRemoteServer

#region importExportPostgresData
# Runs import and export script on remote server
Invoke-Command -ComputerName $remoteServer -FilePath $scriptFilePath -ArgumentList ($importFileName, $fileDir)
#endregion importExportPostgresData

#region copyToExportServer
# Copies the .csv export to the export server
Copy-Item $remotePath $exportServer -Recurse
#endregion copyToExportServer
