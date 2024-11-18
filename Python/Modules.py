# This file houses modules used in the main python script

# Function: End user to select folder
def select_folder():
    import tkinter
    from tkinter import filedialog

    root = tkinter.Tk()
    root.withdraw()

    folder_path = filedialog.askdirectory()

    return folder_path

# Function: Pause the program
def pause():
    input("Press the <ENTER> key to continue...")

# Function: Logging
def log(logfilepath, logmessage):
    import logging

    # "w" overwrites instead of the default behaviour of append
    logging.basicConfig(filename=logfilepath,
                        level=logging.DEBUG,
                        format='%(asctime)s %(message)s',
                        filemode="a")
    
    logging.debug(logmessage)

# Function: Current Time
def time():
    from timeit import default_timer

    return default_timer()

# Function: Find files in a directory
def find_files(directory, type):
    import glob
    import os.path

    files = glob.glob(os.path.join(directory, type))
    return files
