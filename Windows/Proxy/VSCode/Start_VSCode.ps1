# Run the initial configuration based on the user provided password
C:\SOFTWARE\POWERSHELL\common.ps1

# This is the location of VSCode
$WHERE_IS_VSCODE='C:\APPS\VSCode'

# Start the VS Code instance
Start-Process $WHERE_IS_VSCODE/Code.exe -ArgumentList "-n" -PassThru

# Wait for VS Code to exit
Wait-Process -Name "Code"

# Unset .gitconfig of password in clear text
git config --global --unset https.proxy
git config --global --unset http.proxy
