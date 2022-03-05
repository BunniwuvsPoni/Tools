# How to configure SSL on Aruba switches via SSH (Canada/EST)
	
1. Connect to the switch via SSH
2. Go into configuration mode
	- config
3. Create a self-signed certificate
  - crypto pki enroll-self-signed certificate-name [SWITCHNAME] subject
4. Enable HTTPS
  - web-management ssl
5. Disable HTTP
  - no web-management
6. Save the configuration
	- write memory
7. Exit configuration mode
	- exit
8. Confirm configuration was saved
	- show running-config
	- show config
9. Sign out of SSH
	- exit
