# Define the application path and arguments
$appPath = "C:\Program Files\BlueStacks_nxt\HD-Player.exe"
$arguments = "--instance Pie64 --cmd launchAppWithBsx --package `"`com.einnovation.temu`"` --source desktop_shortcut"

# Define the application name
$appName = "HD-Player"

# Stop the application if it's running
Get-Process -Name $appName -ErrorAction SilentlyContinue | Stop-Process -Force

# Start the application with arguments
Start-Process -FilePath $appPath -ArgumentList $arguments
