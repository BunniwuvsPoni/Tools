# Date last updated: 2024/11/17

# This script is intended to: Select a Directory from the local system
def select_directory():
    import sys
    import tkinter
    from tkinter import filedialog

    root = tkinter.Tk()
    root.withdraw()

    folder_path = filedialog.askdirectory()

    if not folder_path:
        sys.exit ("Error: Null or empty directory. Exiting application...")
    else:
        print (folder_path)

    return folder_path
