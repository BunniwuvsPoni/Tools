# Date: 2023/05/25
# This script is intended to: Select a FileName from the system

import tkinter
from tkinter import filedialog

root = tkinter.Tk()
root.withdraw()

file_path = filedialog.askopenfilename()

print (file_path)
