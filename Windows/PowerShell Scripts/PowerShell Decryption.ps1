# This powershell script is intended to show the decryption of account passwords

# Set password
$password = "123456"

# Convert to SecureString
$secureString = ConvertTo-SecureString $password -AsPlainText -Force
$secureString

# Method #1 - Decrypt using BSTR
$bSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secureString)
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bSTR)
$plainPassword

# Method #2 - Decrypt using Network Credential
$unsecurePassword = (New-Object PSCredential "user",$secureString).GetNetworkCredential().Password
$unsecurePassword
