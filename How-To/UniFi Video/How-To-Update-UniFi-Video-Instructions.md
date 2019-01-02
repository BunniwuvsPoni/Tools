# How to update UniFi VIdeo on Debian

1. Go to the temp directory
    - cd /tmp/

2. Download the installation UniFi Video deb file
     - wget (deb direct url) [Found on UBNT's website: https://www.ubnt.com/download/unifi-video]

3. Install the UniFi Video deb file
      - dpkg -i (deb file)

4. Optional, fixes dependency issues
      - apt-get -f install

## Reboot the system
5. Restart Debian to refresh the platform
