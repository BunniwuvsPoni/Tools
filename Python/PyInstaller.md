# PyInstaller
This module is used to create a Windows executable for easier distribution

https://pyinstaller.org/en/stable/

## Install PyInstaller
pip install -U pyinstaller

## Run PyInstaller
python.exe -m PyInstaller -F [.\Script.py]
- The "-F" switch outputs a single executable in the "dist" folder
- The "-m" specifies that the "PyInstaller" *module* is to be used
