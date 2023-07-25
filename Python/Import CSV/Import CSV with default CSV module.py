# This function imports a .CSV file and prints the content to the console using the CSV module
import csv

# Import, process, and print .CSV file
# Setting encoding to UTF-8 due to error: (UnicodeDecodeError: 'charmap' codec can't decode byte 0x90 in position XXX: character maps to <undefined>)
with open("C:\Development\Python\Import CSV\contracts.csv", 'r', encoding='utf-8') as file:
    # Reader is ideal for simply CSV files whereas DictReader is friendlier and easy for use when working with large CSV files
    # Both examples below prints out the the 3rd column of the sample data file
    csv_reader = csv.reader(file)
    for row in csv_reader:
        print(row[2])

    '''
    csv_dict_reader = csv.DictReader(file)
    for row in csv_dict_reader:
        print(row['vendor_name'])
    '''