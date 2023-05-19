# Prevents screen lock until the specified end time at the end of the current day
# Launch using a shortcut with the following parameters: [C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\(directory)\Prevent screen lock - Requires user inputs.ps1"]

# Request end time
$endInput = Read-Host -Prompt "Please specify the end time in the following 24 hour format: (HH:MM). i.e. for 5:15pm your input should be '17:15'"

# Validation of end time
if ($endInput -match "[0-9][0-9]:[0-9][0-9]") {
    # Configuration
    $start = Get-Date "00:00"
    $end = Get-Date $endInput
    $frequency = 30

    echo "Please confirm the date/time the script should terminate (y/n):" $end

    $readhost = Read-Host "(y / n)"

    if($readhost -eq 'n'){
    echo "User did not confirm the specified date/time, closing function."
    Read-Host -Prompt "Press Enter to exit"
    Exit
    }
} else {
    echo "Time must be specified in HH:MM format, closing function."
    Read-Host -Prompt "Press Enter to exit"
    Exit
}

# Initialize Wscript.Shell
$wShell = New-Object -com "Wscript.Shell"

while ($true) {
    # Checks every (x) seconds
    Start-Sleep -Seconds $frequency
    
    # Gets the current date and time
    $date = Get-Date

    # Check if between start and end times
    if($start.TimeOfDay -le $date.TimeOfDay -and $end.TimeOfDay -ge $date.TimeOfDay)
    {
        # Toggles the scroll lock button
        $wShell.sendkeys("{SCROLLLOCK}")
        $wShell.sendkeys("{SCROLLLOCK}")

        # Logging to PowerShell
        Write-Host "Triggered @" $date
    } else {
        # Logging to PowerShell
        Write-Host "Exit @" $date ", time is past specified end time of" $end
        Read-Host -Prompt "Press Enter to exit"
        exit
    }
}
