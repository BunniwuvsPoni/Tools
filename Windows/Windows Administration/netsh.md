# How-To use netsh to import/export wireless profiles

## Show wireless profiles
netsh wlan show profile

## Export wireless profile
netsh wlan export profile (profile) key=clear folder=(dir)

## Import wireless profile
netsh wlan add profile filename="(dir)" user=all
