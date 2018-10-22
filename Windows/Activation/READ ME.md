# Windows activation
## Checking Windows activation status
Current license information - expiration date
- slmgr /xpr

Current license information - detailed view
- slmgr /dlv

## Manual license activation
- Dism /online /Set-Edition: <edition name> /AcceptEula /ProductKey:<x>
