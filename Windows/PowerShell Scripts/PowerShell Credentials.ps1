# This powershell script is intended to record a service accounts credentials for later user

# export path
$export = [Environment]::GetFolderPath("Desktop") + "\Credentials"

# Username path
$usernameFile = $export + "\Username.txt"

# Password path
$passwordFile = $export + "\Password.txt"

# Create directory if it does not exist
if(!(Test-Path $export))
{
    mkdir $export
}

# Save credential if it does not exist
if(!(Test-Path $usernameFile) -or !(Test-Path $passwordFile))
{
    # Record service account credentials
    $credential = Get-Credential

    # Export username
    $username = $credential.UserName
    Set-Content -Path $usernameFile -Value $username

    # Export password as encrypted standard string
    $password = $credential.Password
    $encryptedStandardString = ConvertFrom-SecureString $password
    Set-Content -Path $passwordFile -Value $encryptedStandardString
}
else
{
    # Get the username
    $username = Get-Content -Path $usernameFile

    # Get the encrypted standard string password and convert it to a secure string
    $encryptedStandardString = Get-Content -Path $passwordFile
    $password = ConvertTo-SecureString $encryptedStandardString
}
