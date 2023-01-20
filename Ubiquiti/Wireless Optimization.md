# Ubiquiti Wireless Optimization (for Single/Multi-AP deployments)

Note:

As always, wired offers more capacity and reliability than wireless.
Wired - nearly full gigabit speeds
Wireless - depending on wireless network congestion
2.4Ghz - <100Mbps
5Ghz - <300Mbps

---

1. Wireless site survey (nothing beats an onsite Wi-Fi survey)
2. Tx power: (2.4Ghz - Low) (5Ghz - High)
3. Channel width: (2.4Ghz - 20Mhz) (5Ghz - 40Mhz)
4. Non-overlapping channel selection: (2.4Ghz - 1, 6, and 11) (5Ghz - 36, 44, 149, and 157)
5. Fast roaming set to off
6. High performance devices set to off
7. PMF set to off
8. Auto optimize network set to off
9. Auto upgrade AP firmware set to off

---

Wireless Bands
	- 5Ghz or higher is the peferred connection due to available capacity
	- 2.4Ghz - better range, penetration, and compatibility
	- 5Ghz - better bandwith/capacity due to less congestion

AP Power Levels
	- Set 5Ghz or higher to a higher Tx power level than the 2.4Ghz to give devices a better chance to connect to the less crowded wireless band
	- Increase in Tx power while can increase the range, it doesn't matter if the devices are unable to reply back
	- 2.4Ghz on low Tx power can still reach remarkably far

AP Channels
	- Try to assign non-overlapping channels to avoid interference
	- Do NOT use DFA channels, using 5 GHz Wi-Fi frequencies that are generally reserved for radar, such as military radar, satellite communication, and weather radar

Devices consideration, not all devices/wireless cards are equal, often times an iPhone will produce much better bandwidth numbers than laptops even thought they both are compliant with the wireless standard

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
