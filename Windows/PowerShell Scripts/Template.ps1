<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER <param>

.EXAMPLE

.LINK

#>

###

# Required parameters to process [function]
param(
    [Parameter(Mandatory=$true)][string]$<param>
    )

###

echo "Please confirm the [condition] the script should terminate (y/n):"

$readhost = Read-Host "(y / n)"

if($readhost -eq 'n'){
    echo "User did not confirm the specified [condition], closing function."
    Read-Host -Prompt "Press Enter to exit"
    Exit
}

###

# User selects the folder where the files are located
Add-Type -AssemblyName System.Windows.Forms
$browser = New-Object System.Windows.Forms.FolderBrowserDialog
$null = $browser.ShowDialog()
$folders = $browser.SelectedPath

# Validates that a folder was selected
if ([string]::IsNullOrEmpty($folders)) {
    echo "No folder was selected, exiting script..."
    Read-Host -Prompt “Press ENTER to continue...”
    exit
}

# Verify the folder exists and if not, creates it
$folderPath = "C:\"
if (!(Test-Path -Path $folderPath)) {
    mkdir $folderPath
}
