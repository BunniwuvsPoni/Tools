# Prevents screen lock indefinitely
# Launch using a shortcut with the following parameters: [C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "C:\(directory)\Prevent screen lock - Indefinitely.ps1"]

# Configuration
$frequency = 30

# Initialize Wscript.Shell
$wShell = New-Object -com "Wscript.Shell"

while ($true) {
    # Checks every (x) seconds
    Start-Sleep -Seconds $frequency
    
    # Gets the current date and time
    $date = Get-Date

    # Toggles the scroll lock button
    $wShell.sendkeys("{SCROLLLOCK}")
    $wShell.sendkeys("{SCROLLLOCK}")

    # Logging to PowerShell
    Write-Host "Triggered @" $date
}
