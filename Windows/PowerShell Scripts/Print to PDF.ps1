# This script is intended to take a number of existing PDFs, sending it through the Microsoft Print to PDF printer, to produce "printed" PDF such that PDF viewers can view the files (Some PDF Viewerss cannot handle artefacts in PDFs so this process removes them)
# Note:
# In order for the following function to work...
# You need to manually create a local printer:
# Recommended name due to dependencies: "Microsoft Print to PDF - Automation"
# Using "Microsoft Print to PDF" as the Driver
# Using a local port set to "C:\Microsoft Print to PDF output\Default.pdf"
$defaultPDFViewer = "Acrobat"
$printerName = "Microsoft Print to PDF - Automation"
$defaultPDFPrintPath = "C:\Microsoft Print to PDF output\"
$defaultPDFOutputName = $defaultPDFPrintPath + "Default.pdf"

# Verify the PDF output folder exists and if not, creates it
if (!(Test-Path -Path $defaultPDFPrintPath)) {
    mkdir $defaultPDFPrintPath
}

# Verify if there is a output PDF file already and removes it if it exists
if (Test-Path -Path $defaultPDFOutputName) {
    Remove-Item $defaultPDFOutputName
}

# User selects the folder where the PDFs are located
Add-Type -AssemblyName System.Windows.Forms
$browser = New-Object System.Windows.Forms.FolderBrowserDialog
$null = $browser.ShowDialog()
$folderPDFs = $browser.SelectedPath

# Validates that a folder was selected
if ([string]::IsNullOrEmpty($folderPDFs)) {
    echo "No folder was selected, exiting script..."
    Read-Host -Prompt “Press ENTER to continue...”
    exit
}

# Sets the default printer to the Automation printer
(New-Object -ComObject WScript.Network).SetDefaultPrinter($printerName)

# Finds PDFs in the folder, not searching subfolder(s) due to the complexity of organizing output into the subsequent subfolder(s)
$PDFs = Get-ChildItem -Path $folderPDFs | Where-Object {$_.Extension -eq ".pdf"}

# Creates output folder if not exists
$folderPDFsOutput = $folderPDFs + "\Output\"
mkdir $folderPDFsOutput


# Microsoft Print to PDF
foreach ($PDF in $PDFs) {
    echo "Starting: $PDF.Name"
    
    # Set output file name
    $MicrosoftPrintToPDFFileName = $folderPDFsOutput + $PDF.Name
    
    # Print to Microsoft Print to PDF
    Start-Process -FilePath $PDF.FullName -Verb Print
    
    # Checks for output file creation
    while (!(Test-Path -Path $defaultPDFOutputName)) {
        # Date for progress checking
        Date
        
        # Wait x seconds before trying again
        Start-Sleep -Seconds 1
    }
    
    # Wait x seconds for default output file to write to disk
    Start-Sleep -Seconds 1

    # Closes the default PDF viewer so that the copy function can continue
    Stop-Process -Name $defaultPDFViewer
    
    # Copies the outputed PDF to the Output folder
    Copy-Item $defaultPDFOutputName $MicrosoftPrintToPDFFileName -Force
    
    # Wait x seconds for default PDF Viewer to close so that the default output file can be removed
    Start-Sleep -Seconds 1

    # Deletes the output file
    Remove-Item $defaultPDFOutputName

    echo "Completed: $PDF.Name"
}

# Reset the Default Printer to the "Microsoft Print to PDF"
(New-Object -ComObject WScript.Network).SetDefaultPrinter('Microsoft Print to PDF')
