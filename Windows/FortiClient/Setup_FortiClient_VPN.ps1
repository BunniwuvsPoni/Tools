# Must to ran with ExecutionPolicy Bypass setting

$Name = '<VPN Name>'
$ServerAddress = '<VPN URL>'
$AppID = 'FortinetInc.FortiClient_sq9g7krz3c65j'
Add-VPNConnection -Name $Name -ServerAddress $ServerAddress -PlugInApplicationID $AppID -CustomConfiguration '<forticlient>0</forticlient>' -SplitTunneling
