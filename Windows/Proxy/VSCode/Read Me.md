# VSCode Proxy Configuration
1. Create two new environment variables:
- Navigate to the Windows Start button and search for environment variables.
- Select the Edit environment variables for your account option.
  - Note: You should NOT be prompted for local admin permissions, if you see the prompt, you are in the wrong section (system instead of your account)
- Select New User variables and enter the Variable Names and Variable Values below:

```
Variable Name: Variable Value
HTTP_PROXY: http://username:password@proxy.domain.tld:8080
HTTPS_PROXY: http://username:password@proxy.domain.tld:8080
```

2. Download and modify script
- Create a folder in your local machine’s C drive (C:) called C:\SOFTWARE\POWERSHELL\
- Download the common.ps1 and Start_VSCode.ps1 scripts
  - Download the scripts for common.ps1 and Start_VSCode.ps1 to the folder you created in your C drive.
    - Remember to open and "Save As.." and overwrite the downloaded file as the file isn't digitally signed
  - If needed, edit the variable: "$WHERE_IS_VSCODE" in the Start_VSCode.ps1 script to the location of your VS Code
    - Paste the path for your VS Code, replacing the original entry. Ensure that the single quotes remain, but remove the additional double quotes in your pasted path, as well as the backslash with the Code.exe part of the path.
  - Edit the Start_VSCode.ps1 to refer to the full path of the common.ps1
    - C:\SOFTWARE\POWERSHELL\common.ps1
  - Save and close the file.

3.  Run the script
- Right click on the Start_VSCode.ps1 script and select "Run with PowerShell 7" in the submenu.

4. Create a shortcut on your desktop
- Target:
  - "C:\Program Files\PowerShell\7\pwsh.exe" "C:\SOFTWARE\POWERSHELL\Start_VSCode.ps1"
- Icon:
  - %SystemDrive%\APPS\VSCode\Code.exe
