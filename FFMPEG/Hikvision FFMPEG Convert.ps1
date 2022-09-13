# This script is intended to take a working directory, locate all .mp4 files within that directory, and convert the .mp4 files using FFMPEG outputted into a Converted folder withing said working directory
# This is useful for Hikvision .mp4 files that use the H.265 video and G711U audio codec and convert it into a .mp4 file that can be viewed on most media players

# Obtain the working directory
$application = New-Object -ComObject Shell.Application
$workingDirectory = ($application.BrowseForFolder(0, 'Select a folder', 0)).Self.Path

# FFMPEG directory, ffmpeg.exe must be in the specified directory
$ffmpeg = "C:\Program Files\FFMPEG\bin"
cd $ffmpeg

# Log file
$log = "\Log.txt"

# Checks if working directory was selected
if (!($workingDirectory)) {
    Write-Output "No working directory selected."
    Read-Host -Prompt "Press Enter to exit..."
    exit
}

# Create "Converted" directory
$convertedDirectory = $workingDirectory + "\Converted"
If(!(test-path -PathType container $convertedDirectory))
{
      New-Item -ItemType Directory -Path $convertedDirectory
}

# Updated log file
$logUpdated = $convertedDirectory + $log

# Log initialization
$dateStarted = date
Write-Output "Conversion started: " $dateStarted | Tee-Object -FilePath $logUpdated -Append
Write-Output "Working directory is:" $workingDirectory | Tee-Object -FilePath $logUpdated -Append

# Find all .mp4 files
$filesToConvert = Get-ChildItem -Path $workingDirectory -Filter *.mp4

# Convert all .mp4 files
$fileConvert = ""
$fileConverted = ""
foreach($file in $filesToConvert) {
    Write-Output "Converting file:" $file.Name | Tee-Object -FilePath $logUpdated -Append
    $fileConvert = $workingDirectory + "\" + $file.Name
    $fileConverted = $convertedDirectory + "\" + $file.Name
    .\ffmpeg.exe -i $fileConvert $fileConverted
    Write-Output "Converted file:" $file.Name | Tee-Object -FilePath $logUpdated -Append
}

# Log completion
$dateEnded = date
Write-Output "Converted directory is:" $convertedDirectory | Tee-Object -FilePath $logUpdated -Append
Write-Output "Conversion completed: " $dateEnded | Tee-Object -FilePath $logUpdated -Append
Read-Host -Prompt "Press Enter to exit..."
