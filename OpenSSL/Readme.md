# How to use OpenSSL on Windows

1. Install OpenSSL (https://slproweb.com/products/Win32OpenSSL.html)
2. Self-signed SSL Certificate: openssl req -x509 -newkey rsa:4096 -keyout domain.name.key -out domain.name.crt -sha256 -days 365
3. Create .pfx: openssl pkcs12 -export -out domain.name.pfx -inkey domain.name.key -in domain.name.crt
