# How to send a SMTP email via PowerShell and Telnet

Note:
- Telnet must be installed in order to proceed.
  - Start -> Control Panel -> Programs and Features -> Turn Windows features on or off -> Telnet Client

1. Launch PowerShell
2. Telnet
3. o (SMTP server address) 25
4. ehlo example.com
5. mail from: (alias)@example.com
6. rcpt to: (email)
7. data
9. Subject: (subject)
10. (additional content as required...)
11. "." (dot to send
12. quit
