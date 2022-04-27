# Call Recording Cleanup

## The cron command-line utility, also known as cron job,[1][2] is a job scheduler on Unix-like operating systems.
1. crontab -e
2. 15 1 * * * find /var/spool/asterisk/monitor/ -name "*.wav" -mtime +60 -delete >/dev/null 2>&1
