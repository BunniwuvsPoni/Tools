# How to setup iPerf server on Linux

1. Setup your linux instance
2. Run the following command (installs iPerf, setup the service, enable the service, and starts the service
---
apt-get -y install gdebi iperf3

cat <<- EOF > /etc/systemd/system/iperf3.service

[Unit] Description=iperf3 server After=syslog.target network.target auditd.service

[Service] ExecStart=/usr/bin/iperf3 -s

[Install] WantedBy=multi-user.target

EOF

sudo systemctl enable iperf3; service iperf3 start
---
