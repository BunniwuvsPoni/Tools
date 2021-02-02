# Prevents screen lock during the specified start and end times

# Loading assembly...
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

# Configuration
$start = Get-Date '07:00'
$end = Get-Date '17:00'
$frequency = 30

while ($true) {
    # Checks every (x) seconds
    Start-Sleep -Seconds $frequency
    
    # Gets the current date and time
    $date = Get-Date

    # Check if between start and end times
    if($start.TimeOfDay -le $date.TimeOfDay -and $end.TimeOfDay -ge $date.TimeOfDay)
    {
        # Moves the mouse one pixel to the right and back
        $Pos = [System.Windows.Forms.Cursor]::Position
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((($Pos.X) + 1) , $Pos.Y)
        $Pos = [System.Windows.Forms.Cursor]::Position
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((($Pos.X) - 1) , $Pos.Y)

        # Logging to PowerShell
        Write-Host "Triggered @" $date
    }
}
