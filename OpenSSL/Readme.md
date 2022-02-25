# How to use OpenSSL on Windows

1. Install OpenSSL (https://slproweb.com/products/Win32OpenSSL.html)
2. openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 365
