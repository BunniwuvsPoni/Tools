# Date: 2023/05/25
# This script is intended to: Select a Folder from the system

import tkinter
from tkinter import filedialog

root = tkinter.Tk()
root.withdraw()

folder_path = filedialog.askdirectory()

print (folder_path)
