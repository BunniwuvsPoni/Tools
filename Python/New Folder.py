# Date: 2023/06/26
# This script is intended to: Create a Folder in the file system

import os

path = "C:\Folder"

if not os.path.exists(path):
    os.makedirs(path)
