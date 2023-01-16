# Ubiquiti Wireless Optimization

1. Wireless site survey
2. (Settings -> WiFi -> Global AP Settings) - Power set to low (Auto just means High)
3. (Settings -> WiFi -> Global AP Settings) - Channel width: 2.4Ghz @ 20Mhz & 5Ghz @ 40Mhz
4. (Per AP setting) - Non-overlapping channel selection: 2.4Ghz (1, 6, and 11) & 5Ghz (36, 44, 149, and 157 [do not use DFA channels, using 5 GHz Wi-Fi frequencies that are generally reserved for radar, such as military radar, satellite communication, and weather radar])
5. (Setting -> System -> Updates) - Auto upgrade AP firmware set to off
6. (Settings -> WiFi -> Nightly Channel Optimization) - Auto optimize network set to off
7. (Settings -> WiFi -> SSID (Legacy menu)) - High performance devices set to off

---

AP Power Levels
	- Applies when you have more than one AP with potential overlap in coverage
	- Lower is better to avoid interference

AP Channels
	- When needed, try to assign non-overlapping channels to avoid interference
	- Auto is preferred since it will try to pick the best channel available but in certain circumstances, it might be better to go with manual settings (assuming your environment never changes…)

Smart Queues
	- For when download/upload traffic exceeds download/upload link
	- Tries to share the available bandwidth "fairly" among clients
	- May result in slower router performance
	- Only turn on if you have < 100/10 mbps link

WiFi Ai
	- Wi-Fi AI uses your access points to determine the best and optimum channel configuration based on traffic, deployment size, density and client factors. You should choose a time to run when most WiFi clients are not around
	- Leave turned off, causes more issues that it solves
	
PMF
	- Protected Management Frames
Leave turned off as most devices don't even support this
