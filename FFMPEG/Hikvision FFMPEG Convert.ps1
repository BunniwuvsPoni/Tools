# This script is intended to take a working directory, locate all .mp4 files within that directory, and convert the .mp4 files using FFMPEG outputted into a Converted folder within said working directory
# This is useful for Hikvision .mp4 files that use the H.265 video and G711U audio codec and convert it into a .mp4 file that can be viewed on most media players

# Dependencies
# FFmpeg: https://ffmpeg.org/
# -> Must be installed/extracted into the ("C:\Program Files\FFMPEG\bin") directory
# -> Must be added to the Systems PATH Environmental Variables (Settings -> About -> Advanced system settings -> Environment Variables -> System variables -> Path -> Edit -> New)

# Obtain the working directory
$application = New-Object -ComObject Shell.Application
$workingDirectory = ($application.BrowseForFolder(0, 'Select a folder', 0)).Self.Path

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
Write-Output "Converted directory is:" $convertedDirectory | Tee-Object -FilePath $logUpdated -Append

# Find all .mp4 files
$filesToConvert = Get-ChildItem -Path $workingDirectory -Filter *.mp4

# Convert all .mp4 files
$fileConvert = ""
$fileConverted = ""
foreach($file in $filesToConvert) {
    $startConvert = date
    Write-Output "Converting file: " $file.Name | Tee-Object -FilePath $logFilePath -Append
    Write-Output "Converting file start time: " $startConvert | Tee-Object -FilePath $logFilePath -Append
    
    $fileConvert = $workingDirectory + "\" + $file.Name
    $fileConverted = $convertedDirectory + "\" + $file.Name
    
    ffmpeg.exe -i $fileConvert $fileConverted
    
    $endConvert = date
    Write-Output "File converted: " $file.Name | Tee-Object -FilePath $logFilePath -Append
    Write-Output "File converted end time: " $endConvert | Tee-Object -FilePath $logFilePath -Append
    $diffConvert = $endConvert - $startConvert
    Write-Output "File converted total time (minutes): " $diffConvert.TotalMinutes | Tee-Object -FilePath $logFilePath -Append
}

# Log completion
$dateEnded = date
$totalDuration = $dateEnded - $dateStarted
Write-Output "Conversion completed: " $dateEnded | Tee-Object -FilePath $logFilePath -Append
Write-Output "Total time taken (minutes): " $totalDuration.TotalMinutes | Tee-Object -FilePath $logFilePath -Append
Read-Host -Prompt "Press Enter to exit..."
