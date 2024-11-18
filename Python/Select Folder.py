# Date: 2024/11/17
# This script is intended to: Select a Directory from the local system

def select_directory():
    import tkinter
    from tkinter import filedialog

    root = tkinter.Tk()
    root.withdraw()

    folder_path = filedialog.askdirectory()

    if not folder_path:
        print ("Null or empty directory.")
    else:
        print (folder_path)

    return folder_path
