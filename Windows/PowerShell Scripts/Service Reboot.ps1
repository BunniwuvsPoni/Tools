# This script is intended to restart the named service on the local computer

# Service name
$serviceName = "[Service Name]"

# Log file path
$logFile = "C:\PowerShell Scripts\Service Restarts.txt"

date | Tee-Object -FilePath $logFile -Append
echo "Attempting to restart service:" $serviceName | Tee-Object -FilePath $logFile -Append

Stop-Service -Name $serviceName

date | Tee-Object -FilePath $logFile -Append
echo "Stopped service:" $serviceName | Tee-Object -FilePath $logFile -Append

Start-Service -Name $serviceName

date | Tee-Object -FilePath $logFile -Append
echo "Restarted service:" $serviceName | Tee-Object -FilePath $logFile -Append
