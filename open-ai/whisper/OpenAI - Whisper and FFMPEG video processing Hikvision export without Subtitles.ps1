# This script is intended to:
# -> take a working directory
# -> locate all .mp4 files within that directory
# -> clip (based on automatic speech recognition, Start & End), encode, and loudness normalize using FFMPEG & OpenAI's - Whisper

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
$verificationLog = "\VerificationClippingLog.txt"
# Whisper model (speed and accuracy tradeoffs): tiny, base, small, medium, large
$model = "tiny"
# Whisper model language
$language = "English"
# Buffer configured in seconds in second.milisecond format
$buffer = "5.0"
# No Speech Probability cutoff
$noSpeechProbability = "0.8"
# Exceptions
# Note: Add the wildcard "*" to the beginning and end of the exception
# Note: No periods
# Automatically played 5 minutes remaining notification
$exception5MinutesRemaining = "*five minutes remaining*"
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

# Create "Log" directory
$logDirectory = $workingDirectory + "\Log"
If(!(test-path -PathType container $logDirectory))
{
      New-Item -ItemType Directory -Path $logDirectory
}

# Log initialization
$logUpdated = $logDirectory + $log
$dateStarted = date
Write-Output "Processing started: " $dateStarted | Tee-Object -FilePath $logUpdated -Append
Write-Output "Working directory is: " $workingDirectory | Tee-Object -FilePath $logUpdated -Append
Write-Output "OpenAI-Whisper directory is: " $OpenAIWhisperDirectory | Tee-Object -FilePath $logUpdated -Append
Write-Output "Processed directory is: " $processedDirectory | Tee-Object -FilePath $logUpdated -Append
Write-Output "Log directory is: " $logDirectory | Tee-Object -FilePath $logUpdated -Append
Write-Output "OpenAI-Whisper Model is: " $model | Tee-Object -FilePath $logUpdated -Append
Write-Output "Buffer in seconds.miliseconds is: " $buffer | Tee-Object -FilePath $logUpdated -Append
Write-Output "No Speech Probablility cutoff (percent out of one) is: " $noSpeechProbability | Tee-Object -FilePath $logUpdated -Append
Write-Output "Exceptions are: " $exception5MinutesRemaining | Tee-Object -FilePath $logUpdated -Append
# Verification logging
$verificationLogUpdated = $logDirectory + $verificationLog
Write-Output "Processing started: " $dateStarted | Tee-Object -FilePath $verificationLogUpdated -Append
Write-Output "Working directory is: " $workingDirectory | Tee-Object -FilePath $verificationLogUpdated -Append

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
    # OpenAI - Whisper full file logging
    $startOpenAIWhisperProcessing = date
    Write-Output "OpenAI-Whisper processing full file: " $file.Name | Tee-Object -FilePath $logUpdated -Append
    Write-Output "OpenAI-Whisper processing full file start time: " $startOpenAIWhisperProcessing | Tee-Object -FilePath $logUpdated -Append
    
    # OpenAI-Whisper processing, Floating Point 16 -> 32, slower but more accurate results, 16 vs 32 bits, also seems like not a lot of CPUs support FP16...
    whisper.exe $file.Name --model $model --language $language --fp16 False
    
    # OpenAI - Whisper full file logging
    $endOpenAIWhisperProcessing = date
    Write-Output "OpenAI-Whisper processed full file end time: " $endOpenAIWhisperProcessing | Tee-Object -FilePath $logUpdated -Append
    
    # Sets the .json file name
    $OpenAIWhisperJSONPath = $file.BaseName + ".json"

    # Imports .json into PowerShell
    $OpenAIWhisperJSON = Get-Content -Raw -Path $OpenAIWhisperJSONPath  | ConvertFrom-Json

    # Set .json detailed export file name
    $OpenAIWhisperJSONToTXT = $logDirectory + "\" + $file.BaseName + " - Detailed.txt"
    
    # Log start of detailed export
    Write-Output "OpenAI-Whisper JSON to TXT file: " $file.Name | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append

    # Calculates the clipping start and end points based on the configured no speech probability value
    foreach ($segment in $OpenAIWhisperJSON.segments)
    {
        # Convert JSON Details to TXT for human readability
        Write-Output "ID: " $segment.id | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append
        Write-Output "No Speech Probability: " $segment.no_speech_prob | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append
        Write-Output "Start (seconds): " $segment.start | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append
        Write-Output "End (seconds): " $segment.end | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append
        Write-Output "Text: " $segment.text | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append
                
        if ($segment.no_speech_prob -le $noSpeechProbability)
        {
            # Log match of No Speech Probability check
            Write-Output "No Speech Probability: MATCH" | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append

            # Sets Clip Start/End variables
            if ($segment.text -like $exception5MinutesRemaining)
            {
                # Skipping due to question playing the 5 minute reminder
                Write-Output "Skipping due to exception: " $exception5MinutesRemaining | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append
            } elseif ($clipStart -eq "")
            {
                $clipStart = $segment.start
            } elseif ($clipEnd -le $segment.end)
            {
                $clipEnd = $segment.end
            }
        }
    }

    # Log end of detailed export
    Write-Output "OpenAI-Whisper JSON to TXT file export completed." | Tee-Object -FilePath $OpenAIWhisperJSONToTXT -Append

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

    # Logs clipping start and end time(s)
    $startFFMPEGProcessClipping = date
    Write-Output "FFMPEG Processing Clipping start time: " $startFFMPEGProcessClipping | Tee-Object -FilePath $logUpdated -Append
    Write-Output "Clipping start time: " $clipStartFormatted | Tee-Object -FilePath $logUpdated -Append
    Write-Output "Clipping end time: " $clipEndFormatted | Tee-Object -FilePath $logUpdated -Append

    # Verification logging
    Write-Output "Processing file: " $file.Name | Tee-Object -FilePath $verificationLogUpdated -Append
    Write-Output "Clipping start time: " $clipStartFormatted | Tee-Object -FilePath $verificationLogUpdated -Append
    Write-Output "Clipping end time: " $clipEndFormatted | Tee-Object -FilePath $verificationLogUpdated -Append

    # FFMPEG input/output file paths
    $fileProcess = $workingDirectory + "\" + $file.Name
    $fileProcessed = $processedDirectory + "\" + $file.Name
    
    # Encoding, clipping (-ss xx:xx:xx -to yy:yy:yy), and Loudness Normalization (-filter:a loudnorm)
    ffmpeg.exe -i $fileProcess -ss $clipStartFormatted -to $clipEndFormatted -filter:a loudnorm $fileProcessed

    # Move OpenAI-Whisper output files (.json, .srt, .tsv, .txt, .vtt) to the OpenAI-Whisper directory
    Get-ChildItem -Filter *.json | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.srt | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.tsv | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.txt | Move-Item -Destination $OpenAIWhisperDirectory
    Get-ChildItem -Filter *.vtt | Move-Item -Destination $OpenAIWhisperDirectory

    # Logs FFMPEG clipping end time
    $endFFMPEGProcessClipping = date
    Write-Output "FFMPEG Processing Clipping end time: " $endFFMPEGProcessClipping | Tee-Object -FilePath $logUpdated -Append

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
Write-Output "Processing completed: " $dateEnded | Tee-Object -FilePath $verificationLogUpdated -Append # Verification logging
Write-Output "Total time taken (minutes): " $totalDuration.TotalMinutes | Tee-Object -FilePath $logUpdated -Append
Read-Host -Prompt "Press Enter to exit..."
