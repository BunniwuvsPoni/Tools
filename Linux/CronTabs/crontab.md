# Crontab notes

## sudo crontab -e vs crontab -e
Determines if the crontab task are run as root or the currently logged in user

## Directory	Description
/etc/cron.d/
  Put all scripts here and call them from /etc/crontab file
/etc/cron.daily/
  Run all scripts once a day
/etc/cron.hourly/
  Run all scripts once an hour
/etc/cron.monthly/
  Run all scripts once a month
/etc/cron.weekly/
  Run all scripts once a week
