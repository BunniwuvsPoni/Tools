# How to configure NTP server on Aruba switches via SSH (Canada/EST)
	
1. Connect to the switch via SSH
2. Go into configuration mode
	- config
3. Setup daylight savings rules
	- time daylight-time-rule continental-us-and-canada
4. Set the time zone
	- time timezone -300
5. Configure DNS server
	- ip dns server-address priority 1 (ip address)
	- ip dns server-address priority 2 (ip address)
6. Set timesync to NTP
	- timesync ntp
7. Set to unicast
	- ntp unicast
8. Set the NTP server
	- ntp server-name pool.ntp.org iburst
9. Enable the NTP service
	- ntp enable
10. Verify NTP sync is working
	- show time
	- show ntp status
	- show ntp statistics
11. Save the configuration
	- write memory
12. Exit configuration mode
	- exit
13. Confirm configuration was saved
	- show running-config
	- show config
14. Sign out of SSH
	- exit
