## Get the password
$message="Enter Password for " + $env:username
$password = Read-Host -Prompt $message -AsSecureString
$MYCPW=[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

# Create proxy string
$proxy='http://'+ $env:username + ':' + $MYCPW +'@proxy.domain.tld:8080'

# Set environmental variable with proxy
$env:HTTPS_PROXY=$proxy
$env:HTTP_PROXY=$proxy

# Set .gitconfig proxy
git config --global https.proxy $proxy
git config --global http.proxy $proxy
