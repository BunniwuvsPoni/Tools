# How to setup iPerf server on Linux

1. Setup your linux instance
2. Install iPerf with dependencies (apt-get -y install gdebi iperf3)
3. Create the following file (/etc/systemd/system/iperf3.service)

---

[Unit]
Description=iperf3 server
After=syslog.target network.target auditd.service

[Service]
ExecStart=/usr/bin/iperf3 -s

[Install]
WantedBy=multi-user.target

---

4. Enable the service (sudo systemctl enable iperf3)
5. Start the service (service iperf3 start)
