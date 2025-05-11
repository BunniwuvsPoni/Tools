# Define the application path and arguments
$appPath = "C:\Program Files\BlueStacks_nxt\HD-Player.exe"
# Temu - Main
$arguments_app1 = "--instance Pie64 --cmd launchAppWithBsx --package `"`com.einnovation.temu`"` --source desktop_shortcut"
# Temu - Claim Credit
$arguments_app2 = "--instance Pie64_1 --cmd launchAppWithBsx --package `"`com.einnovation.temu`"` --source desktop_shortcut"

# Define the application name
$appName = "HD-Player"
$appNameBlueStacksX = "BlueStacks X"

# Stop the application if it's running
Get-Process -Name $appName -ErrorAction SilentlyContinue | Stop-Process -Force

# Temu - Main: Start the application with arguments
Start-Process -FilePath $appPath -ArgumentList $arguments_app1

# Wait 30s
Start-Sleep -Seconds 30

# Temu - Claim Credit: Start the application with arguments
Start-Process -FilePath $appPath -ArgumentList $arguments_app2

# Wait 30s
Start-Sleep -Seconds 30

# Stop the "BlueStacks X" application if it's running
Get-Process -Name $appNameBlueStacksX -ErrorAction SilentlyContinue | Stop-Process -Force
