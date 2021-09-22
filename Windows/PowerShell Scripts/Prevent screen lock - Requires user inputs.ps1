# Prevents screen lock during the specified start and end times
# Launch using PowerShell

# Configuration
param(
    [Parameter(Mandatory=$true)][string]$endInput
    )

$start = Get-Date "00:00"
$end = Get-Date $endInput
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
    } else {
        # Logging to PowerShell
        Write-Host "Exit @" $date ", time is past specified end time of" $end
        exit
    }
}
