# Ubiquiti Wireless Optimization

Note:
As always, wired offers more capacity and reliability than wireless

1. Wireless site survey (nothing beats an onsite Wi-Fi survey)
2. Tx power: (2.4Ghz - Low) (5Ghz - High)
3. Channel width: (2.4Ghz - 20Mhz) (5Ghz - 40Mhz)
4. Non-overlapping channel selection: (2.4Ghz - 1, 6, and 11) (5Ghz - 36, 44, 149, and 157)
5. Auto upgrade AP firmware set to off
6. Auto optimize network set to off
7. High performance devices set to off

---

Wireless Bands
	- 5Ghz or higher is the peferred connection due to available capacity
	- 2.4Ghz - better range, penetration, and compatibility
	- 5Ghz - better bandwith/capacity due to less congestion

AP Power Levels
	- Set 5Ghz or higher to a higher Tx power level than the 2.4Ghz to give devices a better chance to connect to the less crowded wireless band

AP Channels
	- Try to assign non-overlapping channels to avoid interference
	- Do NOT use DFA channels, using 5 GHz Wi-Fi frequencies that are generally reserved for radar, such as military radar, satellite communication, and weather radar

Smart Queues
	- For when download/upload traffic exceeds download/upload link
	- Tries to share the available bandwidth "fairly" among clients
	- May result in slower router performance
	- Only turn on if you have < 100/10 mbps link

WiFi Ai
	- Wi-Fi AI uses your access points to determine the best and optimum channel configuration based on traffic, deployment size, density and client factors. You should choose a time to run when most WiFi clients are not around
	- Leave turned off, causes more issues that it solves
	
PMF
	- Protected Management Frames, leave turned off as most devices don't even support this
