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
- Dism /online /Set-Edition: (edition name) /AcceptEula /ProductKey:(xxxxx-xxxxx-xxxxx-xxxxx-xxxxx)
