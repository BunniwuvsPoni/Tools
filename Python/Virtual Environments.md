# Python Virtual Environments

## VSCode
https://code.visualstudio.com/docs/python/environments

- Open the Command Palette (Ctrl+Shift+P)
- Python: Create Environment
- Test: echo $Env:VIRTUAL_ENV

## Python

### Create the virtual environment
- python.exe -m venv .venv
### Activate the virtual environment
- .\\.venv\Scripts\Activate.ps1
  - If required, set execution policy to RemoteSigned
      - Set-ExecutionPolicy RemoteSigned
      - Get-ExecutionPolicy
- Test: echo $Env:VIRTUAL_ENV
