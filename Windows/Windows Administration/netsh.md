# How-To use netsh to import/export wireless profiles

## Show wireless profiles
netsh wlan show profile

## Export wireless profile
netsh wlan export profile (profile) key=clear folder=(dir)
Review and ensure the proper SSID password is set in the exported configuration file:
				<protected>false</protected>
				<keyMaterial>(SSID password)</keyMaterial>

## Import wireless profile
netsh wlan add profile filename="(dir)" user=all
