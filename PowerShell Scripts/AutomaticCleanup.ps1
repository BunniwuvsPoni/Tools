## powershell.exe -ExecutionPolicy Bypass "File path to powershell script".ps1

Get-ChildItem –Path "File path to folder" -Recurse | Where-Object {!$_.PSIsContainer} | Where-Object {($_.LastWriteTime -lt (Get-Date).AddDays(-7))} | Remove-Item
