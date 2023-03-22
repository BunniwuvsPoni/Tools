xcopy \\[Server]\Software\ODT C:\Windows\Temp\O365 /E /I /Y

C:\Windows\Temp\O365\setup.exe /CONFIGURE C:\Windows\Temp\O365\install.xml

Remove-Item -Recurse -Force C:\Windows\Temp\O365\

exit
