# Windows activation
## Checking Windows activation status
Current license information - expiration date
- slmgr /xpr

Current license information - detailed view
- slmgr /dlv

## Check current version
- Dism /online /Get-CurrentEdition

## Check upgradeable versions
- Dism /online /Get-TargetEditions

## Manual license activation
- Dism /online /Set-Edition:(edition name) /AcceptEula /ProductKey:(xxxxx-xxxxx-xxxxx-xxxxx-xxxxx)


# This step activates Windows with the original OEM key
- $Productkey = (Get-WmiObject -Class SoftwareLicensingService).OA3xOriginalProductkey # Get the original OEM key
- cscript /b C:\Windows\System32\slmgr.vbs -ipk $Productkey # Install the OEM key
- cscript /b C:\Windows\System32\slmgr.vbs -ato # Activate the OEM key with Microsoft online
