# This script is intended to take a working directory -> locate all .mp4 files within that directory -> clip (based on speech recognition, Start & End), convert, loudness normalize, and add subtitles the .mp4 files using FFMPEG & OpenAI's - Whisper
# Files are expected to be outputted into a number of folders within said working directory
# This is useful for Hikvision .mp4 files that use the H.265 video and G711U audio codec and convert it into a .mp4 file that can be viewed on most media players

# Dependencies
# Open-AI: Whisper: https://github.com/openai/whisper
# Python: https://www.python.org/
# Microsoft Visual C++ Redistributable: https://aka.ms/vs/16/release/vc_redist.x64.exe
# FFMPEG: https://ffmpeg.org/

# Install instructions: https://github.com/BunniwuvsPoni/Tools/blob/master/open-ai/whisper/Windows%20-%20Multi-User%20Setup%20Process.md

### Configuration ###
# Log file
$log = "\Log.txt"
# Verification file
$verificationLog = "\Verification.txt"
# Whisper model (speed and accuracy tradeoffs): tiny, base, small, medium, large
$model = "tiny"
# Buffer configured in seconds in second.milisecond format
$buffer = "5.0"
# No Speech Probability cutoff
$noSpeechProbability = "0.8"
### Configuration ###

# Obtain the working directory for the video files
$application = New-Object -ComObject Shell.Application
$workingDirectory = ($application.BrowseForFolder(0, 'Select a folder', 0)).Self.Path

# Checks if working directory was selected
if (!($workingDirectory)) {
    Write-Output "No working directory selected. Exiting..."
    Read-Host -Prompt "Press Enter to exit..."
    exit
}

# Navigate PowerShell to working directory
cd $workingDirectory

# Create "OpenAI-Whisper" directory
$OpenAIWhisperDirectory = $workingDirectory + "\OpenAI-Whisper"
If(!(test-path -PathType container $OpenAIWhisperDirectory))
{
      New-Item -ItemType Directory -Path $OpenAIWhisperDirectory
}

# Create "Processed" directory
$processedDirectory = $workingDirectory + "\Processed"
If(!(test-path -PathType container $processedDirectory))
{
      New-Item -ItemType Directory -Path $processedDirectory
}

# Log initialization
$logUpdated = $OpenAIWhisperDirectory + $log
$dateStarted = date
Write-Output "Processing started: " $dateStarted | Tee-Object -FilePath $logUpdated -Append
Write-Output "Working directory is:" $workingDirectory | Tee-Object -FilePath $logUpdated -Append
Write-Output "OpenAI-Whisper directory is:" $OpenAIWhisperDirectory | Tee-Object -FilePath $logUpdated -Append
Write-Output "Processed directory is:" $processedDirectory | Tee-Object -FilePath $logUpdated -Append
# Verification logging
$verificationLogUpdated = $OpenAIWhisperDirectory + $verificationLog
Write-Output "Processing started: " $dateStarted | Tee-Object -FilePath $verificationLogUpdated -Append
Write-Output "Working directory is:" $workingDirectory | Tee-Object -FilePath $verificationLogUpdated -Append

# Find all .mp4 files
$filesToProcess = Get-ChildItem -Path $workingDirectory -Filter *.mp4

# OpenAI-Whisper processing
# Variables configuration
$fileProcess = ""
$OpenAIWhisperJSON = ""
$clipStart = ""
$clipEnd = ""

# Processing each video file
foreach($file in $filesToProcess) {
    # OpenAI - Whisper logging
    $startOpenAIWhisperProcessing = date
    Write-Output "OpenAI-Whisper processing file: " $file.Name | Tee-Object -FilePath $logUpdated -Append
    Write-Output "OpenAI-Whisper processing file start time: " $startOpenAIWhisperProcessing | Tee-Object -FilePath $logUpdated -Append
    
    # OpenAI-Whisper processing, Floating Point 16 -> 32, slower but more accurate results, 16 vs 32 bits, also seems like not a lot of CPUs support FP16...
    whisper.exe $file.Name --model $model --language English --fp16 False
    
    # OpenAI - Whisper logging
    $endOpenAIWhisperProcessing = date
    Write-Output "OpenAI-Whisper processed file end time: " $endOpenAIWhisperProcessing | Tee-Object -FilePath $logUpdated -Append
    
    # Sets the .json file name
    $OpenAIWhisperJSONPath = $file.BaseName + ".json"

    # Imports .json into PowerShell
    $OpenAIWhisperJSON = Get-Content -Raw -Path $OpenAIWhisperJSONPath  | ConvertFrom-Json

    # Calculates the clipping start and end points based on the configured no speech probability value
    foreach ($segment in $OpenAIWhisperJSON.segments)
    {
        if ($segment.no_speech_prob -le $noSpeechProbability)
        {
            if ($clipStart -eq "")
            {
                $clipStart = $segment.start
            } elseif ($clipEnd -le $segment.end)
            {
                $clipEnd = $segment.end
            }
        }
    }

    # Add buffer to time
    # Accounting for words at the very start of the session...
    if ($clipStart -eq "" -or $clipEnd -eq "")
    {
        Write-Output "Error encountered: (" $file.Name ") does not have a valid Start or End time, please see your local administrator for assistance..." | Tee-Object -FilePath $logUpdated -Append
        Read-Host -Prompt "Press Enter to exit..."
        exit    
    } elseif ($clipStart -le $buffer)
    {
        $clipStart = "0.0" # Start time shouldn't have a negative value...
    } else {
        $clipStart = $clipStart - $buffer
    }

    # As at 04/11/2023, this seems to be okay as it looks like FFMPEG just skips the extra bit at the end with no content...
    $clipEnd = $clipEnd + $buffer

    # Convert clipping time to hh:mm:ss format
    $clipStartTimeSpan = [timespan]::FromSeconds($clipStart)
    $clipStartFormatted = $clipStartTimeSpan.ToString("hh\:mm\:ss")
    $clipEndTimeSpan = [timespan]::FromSeconds($clipEnd)
    $clipEndFormatted = $clipEndTimeSpan.ToString("hh\:mm\:ss")

    # Sets the .srt file name
    $OpenAIWhisperSRTPath = $file.BaseName + ".srt"
    # Sets the copied .srt .txt file path
    $copySRTToTXT = $processedDirectory + "\" + $OpenAIWhisperSRTPath + ".txt"

    # Logs clipping start and end time(s)
    $startFFMPEGProcessing = date
    Write-Output "FFMPEG Processing start time: " $startFFMPEGProcessing | Tee-Object -FilePath $logUpdated -Append
    Write-Output "Clipping start time: " $clipStartFormatted | Tee-Object -FilePath $logUpdated -Append
    Write-Output "Clipping end time: " $clipEndFormatted | Tee-Object -FilePath $logUpdated -Append

    # Verification logging
    Write-Output "Processing file: " $file.Name | Tee-Object -FilePath $verificationLogUpdated -Append
    Write-Output "Clipping start time: " $clipStartFormatted | Tee-Object -FilePath $verificationLogUpdated -Append
    Write-Output "Clipping end time: " $clipEndFormatted | Tee-Object -FilePath $verificationLogUpdated -Append

    # FFMPEG
    $fileProcess = $workingDirectory + "\" + $file.Name
    $fileProcessed = $processedDirectory + "\" + $file.Name
    
    # Conversion, clipping (-ss xx:xx:xx -to yy:yy:yy), adding subtitles (-vf subtitles=subtitle.srt), and Loudness Normalization (-filter:a loudnorm) happens here
    ffmpeg.exe -i $fileProcess -ss $clipStartFormatted -to $clipEndFormatted -filter:a loudnorm -vf subtitles=$OpenAIWhisperSRTPath $fileProcessed

    # Copy .srt to a .txt file
    Copy-Item $OpenAIWhisperSRTPath $copySRTToTXT

    # Move OpenAI-Whisper output files (.json, .srt, .tsv, .txt, .vtt) to the OpenAI-Whisper directory
    Get-ChildItem -Filter *.json | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.srt | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.tsv | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.txt | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.vtt | Move-Item -Destination $OpenAIWhisperDirectory
    
    # Log file completion    
    $endProcessed = date
    Write-Output "File processed: " $file.Name | Tee-Object -FilePath $logUpdated -Append
    Write-Output "File processed end time: " $endProcessed | Tee-Object -FilePath $logUpdated -Append
    $diffProcess = $endProcessed - $startOpenAIWhisperProcessing
    Write-Output "File total processing time (minutes): " $diffProcess.TotalMinutes | Tee-Object -FilePath $logUpdated -Append
    # Verification log file completion
    Write-Output "File processed: " $file.Name | Tee-Object -FilePath $verificationLogUpdated -Append

    # Reset clipping start and end times
    $clipStart = ""
    $clipEnd = ""
}

# Log completion
$dateEnded = date
$totalDuration = $dateEnded - $dateStarted
Write-Output "Processing completed: " $dateEnded | Tee-Object -FilePath $logUpdated -Append
# Verification logging
Write-Output "Processing completed: " $dateEnded | Tee-Object -FilePath $verificationLogUpdated -Append
Write-Output "Total time taken (minutes): " $totalDuration.TotalMinutes | Tee-Object -FilePath $logUpdated -Append
Read-Host -Prompt "Press Enter to exit..."
