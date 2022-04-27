# Call Recording Cleanup

1. crontab -e
    - The cron command-line utility, also known as cron job, is a job scheduler on Unix-like operating systems
3. 0 1 * * * find /var/spool/asterisk/monitor/ -name "*.wav" -mtime +183 -delete >/dev/null 2>&1
    - Everyday @ 1am, find and delete call recordings greater than 183 days, no output


Notes:

Whenever you execute a program, the operating system always opens three files, standard input, standard output, and standard error as we know whenever a file is opened, the operating system (from kernel) returns a non-negative integer called a file descriptor. The file descriptor for these files are 0, 1, and 2, respectively.

https://stackoverflow.com/questions/10508843/what-is-dev-null-21
