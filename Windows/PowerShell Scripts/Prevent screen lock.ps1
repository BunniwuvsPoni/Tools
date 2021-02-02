# Prevents screen lock during the specified start and end times

$start = Get-Date '07:00'
$end = Get-Date '17:00'

while ($true) {
    # Checks every 30 seconds
    Start-Sleep -Seconds 30
    
    # Gets the current date and time
    $date = Get-Date

    # Check if between start and end times
    if($start.TimeOfDay -le $date.TimeOfDay -and $end.TimeOfDay -ge $date.TimeOfDay)
    {
        # Moves the mouse one pixel to the right and back
        $Pos = [System.Windows.Forms.Cursor]::Position
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((($Pos.X) + 1) , $Pos.Y)
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((($Pos.X) - 1) , $Pos.Y)

        # Logging to PowerShell
        Write-Host "Triggered @" $date
    }
}
