# Date: 2023/06/26
# This script is intended to: Log events

import logging

path = "C:\Folder\log.txt"

# "w" overwrites instead of the default behaviour of append
logging.basicConfig(filename=path,
                    level=logging.DEBUG,
                    format='%(asctime)s %(message)s',
                    filemode="w")



logging.debug("Debug: 10")
logging.info("Info: 20")
logging.warning("Warning: 30")
logging.error("Error: 40")
logging.critical("Critical: 50")
