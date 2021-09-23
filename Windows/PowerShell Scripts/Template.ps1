<#
.SYNOPSIS

.DESCRIPTION

.PARAMETER <param>

.EXAMPLE

.LINK

#>

# Required parameters to process O365 permissions change
param(
    [Parameter(Mandatory=$true)][string]$<param>
    )

echo "Please confirm the [condition] the script should terminate (y/n):"

$readhost = Read-Host "(y / n)"

if($readhost -eq 'n'){
    echo "User did not confirm the specified [condition], closing function."
    Read-Host -Prompt "Press Enter to exit"
    Exit
}
