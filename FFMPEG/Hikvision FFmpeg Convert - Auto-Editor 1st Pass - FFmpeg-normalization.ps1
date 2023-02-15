# This script is intended to:
# 1. Take a working directory
# 2. Locate all .mp4 files within that directory (does not go into subfolders)
# 3. Convert the .mp4 files using FFMPEG outputted into a Converted folder within said working directory
# 4. 1st pass the .mp4 files using Auto-Editor to remove silence/dead space into a 1st Pass folder within said working directory
# 5. Normalize the loudness of the 1st pass .mp4 files using FFMPEG-Normalization into a Ready for Production folder within said working directory

# This is useful for Hikvision .mp4 files that use the H.265 video and G711U audio codec and convert it into a .mp4 file that can be viewed on most media players

# Dependencies
# FFmpeg: https://ffmpeg.org/
# -> Must be installed/extracted into the ("C:\Program Files\FFMPEG\bin") directory
# -> Must be added to the Systems PATH Environmental Variables (Settings -> About -> Advanced system settings -> Environment Variables -> System variables -> Path -> Edit -> New)
# Python: https://www.python.org/
# -> Add python.exe to PATH must be enabled
# -> Python must be installed for all users (Customize installation -> Next -> Install Python [version] for all users)
# Auto-Editor: https://auto-editor.com/
# -> Run PowerShell as an administrator
# -> Update pip: py.exe -m pip install --upgrade pip
# -> Install Auto-Editor: pip.exe install auto-editor
# FFmpeg-Normalize: https://github.com/slhck/ffmpeg-normalize
# -> Run PowerShell as an administrator
# -> Install FFmpeg-Normalize: pip.exe install ffmpeg-normalize

# Variables declaration
# Auto-Editor --Margin setting
$autoEditorMargin = "8" + "sec"

# Log file name
$log = "\Conversion Log.txt"

# Obtain the working directory
$application = New-Object -ComObject Shell.Application
$workingDirectory = ($application.BrowseForFolder(0, 'Select a folder', 0)).Self.Path

# Checks if working directory was selected
if (!($workingDirectory)) {
    Write-Output "No working directory selected."
    Read-Host -Prompt "Press Enter to exit..."
    exit
}

# Create "Converted/1st Pass/Ready for Production" directory
$convertedDirectory = $workingDirectory + "\1 - Converted"
$1stPassDirectory = $workingDirectory + "\2 - 1st Pass"
$readyForProductionDirectory = $workingDirectory + "\3 - Ready for Production"
If(!(test-path -PathType container $convertedDirectory))
{
      New-Item -ItemType Directory -Path $convertedDirectory
}
If(!(test-path -PathType container $1stPassDirectory))
{
      New-Item -ItemType Directory -Path $1stPassDirectory
}
If(!(test-path -PathType container $readyForProductionDirectory))
{
      New-Item -ItemType Directory -Path $readyForProductionDirectory
}

# Updated log file path
$logFilePath = $workingDirectory + $log

# Log initialization
$dateStarted = date
Write-Output "Conversion started: " $dateStarted | Tee-Object -FilePath $logFilePath -Append
Write-Output "Working directory is: " $workingDirectory | Tee-Object -FilePath $logFilePath -Append
Write-Output "Converted directory is: " $convertedDirectory | Tee-Object -FilePath $logFilePath -Append
Write-Output "1st Pass directory is: " $1stPassDirectory | Tee-Object -FilePath $logFilePath -Append
Write-Output "Ready for Production directory is: " $readyForProductionDirectory | Tee-Object -FilePath $logFilePath -Append
Write-Output "Dead space marge is set to: " $autoEditorMargin | Tee-Object -FilePath $logFilePath -Append

# Find all .mp4 files
$filesToConvert = Get-ChildItem -Path $workingDirectory -Filter *.mp4

# Set variable to convert all .mp4 files
$fileConvert = ""
$fileConverted = ""
$file1stPass = ""
$fileLoudnessNormalization = ""

# Converting all .mp4 files
foreach($file in $filesToConvert) {
    
    # 1st pass, convert file to workable format
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

    # 2nd pass, remove dead space
    $startAutoEditor = date
    Write-Output "Removing dead space from file: " $file.Name | Tee-Object -FilePath $logFilePath -Append
    Write-Output "Removal start time: " $startAutoEditor | Tee-Object -FilePath $logFilePath -Append
    
    $file1stPass = $1stPassDirectory + "\" + $file.Name
    
    auto-editor.exe $fileConverted -o $file1stPass --margin $autoEditorMargin --no-open
    
    $endAutoEditor = date
    Write-Output "Dead space removed from: " $file.Name | Tee-Object -FilePath $logFilePath -Append
    Write-Output "Removal end time: " $endAutoEditor | Tee-Object -FilePath $logFilePath -Append
    $diffAutoEditor = $endAutoEditor - $startAutoEditor
    Write-Output "File dead space removal total time (minutes): " $diffAutoEditor.TotalMinutes | Tee-Object -FilePath $logFilePath -Append
    
    # 3rd pass, loudness normalization
    $startLoudnessNormalization = date
    Write-Output "Performing loudness normalization on file: " $file.Name | Tee-Object -FilePath $logFilePath -Append
    Write-Output "Loudness normalization start time: " $startLoudnessNormalization | Tee-Object -FilePath $logFilePath -Append
    
    $fileLoudnessNormalization = $readyForProductionDirectory + "\" + $file.Name
    
    ffmpeg-normalize.exe $file1stPass -o $fileLoudnessNormalization -c:a aac -pr
    
    $endLoudnessNormalization = date
    Write-Output "Loudness normalization performed on file: " $file.Name | Tee-Object -FilePath $logFilePath -Append
    Write-Output "Loudness normalization end time: " $endLoudnessNormalization | Tee-Object -FilePath $logFilePath -Append
    $diffLoudnessNormalization = $endLoudnessNormalization - $startLoudnessNormalization
    Write-Output "Loudness normalization total time (minutes): " $diffLoudnessNormalization.TotalMinutes | Tee-Object -FilePath $logFilePath -Append

    # Total time spent on File going through the passes
    $diffFile = $endLoudnessNormalization - $startConvert
    Write-Output "Total time spent on File (minutes): " $diffFile.TotalMinutes | Tee-Object -FilePath $logFilePath -Append
}

# Log completion
$dateEnded = date
$totalDuration = $dateEnded - $dateStarted
Write-Output "Conversion completed: " $dateEnded | Tee-Object -FilePath $logFilePath -Append
Write-Output "Total time taken (minutes): " $totalDuration.TotalMinutes | Tee-Object -FilePath $logFilePath -Append
Read-Host -Prompt "Press Enter to exit..."
