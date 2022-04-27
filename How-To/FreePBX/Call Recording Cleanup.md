# Call Recording Cleanup

1. crontab -e
2. 15 1 * * * find /var/spool/asterisk/monitor/ -name "*.wav" -mtime +60 -delete >/dev/null 2>&1
