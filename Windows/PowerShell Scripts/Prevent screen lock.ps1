# Prevents screen lock during the specified start and end times
# Launch using a shortcut with the following parameters: [C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\(directory)\Prevent screen lock.ps1"]

# Configuration
$start = Get-Date '07:30'
$end = Get-Date '16:00'
$frequency = 30

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
    }
}
