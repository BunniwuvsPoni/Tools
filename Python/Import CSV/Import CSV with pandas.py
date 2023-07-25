# This function imports a .CSV file and prints the content to the console using pandas
import pandas

# Import and process .CSV file
file = 'C:\Development\Python\Import CSV\contracts.csv'
dataFile = pandas.read_csv(file)

# Default is to display 60 rows, when above this amount, the first and last 5 rows are displayed
print(dataFile.head(65))

'''
# Sets the maximum number of rows to display, default is 60
pandas.options.display.max_rows = 1000

# The column labels of the DataFrame
print(dataFile.columns)
# Print a concise summary of a DataFrame
print(dataFile.info())
# Print the dataframe
print(dataFile)
'''