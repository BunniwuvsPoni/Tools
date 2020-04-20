# This powershell script is intended to show the encryption of account passwords

# Set password
$password = "123456"

# Convert to SecureString using DPAPI, this working great if you are accessing the password from the same computer
$secureString = ConvertTo-SecureString $password -AsPlainText -Force
$secureString

# What if you need to access the password from a different password? This is where the encryption key comes into play
# Set encryption key
[Byte[]] $key = (1..16)

# Convert to SecureString using the encryption key
$keyEncryptedSecureString = ConvertFrom-SecureString $secureString -Key $key
$keyEncryptedSecureString

$secureStringAccessedUsingKey = ConvertTo-SecureString $keyEncryptedSecureString -Key $key
$secureString
