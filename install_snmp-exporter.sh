cd /opt	;
/usr/bin/wget https://github.com/prometheus/snmp_exporter/releases/download/v0.21.0/snmp_exporter-0.21.0.linux-amd64.tar.gz ;
tar xvf snmp_exporter*.tar.gz	;
mv snmp_exporter-0.21.0.linux-amd64 snmp_exporter	;
cd /snmp_exporter	;
/bin/chmod +x snmp_exporter	;

# create systemd service
#========#==========#======
sudo tee /etc/systemd/system/snmp_exporter.service<<EOF
[Unit]
Description=SNMP Exporter
After=network-online.target
[Service]
#User=prometheus
Restart=on-failure
ExecStart=/opt/snmp_exporter/snmp_exporter --config.file='/opt/snmp_exporter/snmp.yml'
[Install]
WantedBy=multi-user.target
EOF

# Reload services file
#========#=========#====
/bin/systemctl daemon-reload	;

# Restart the services
#====#===========#======
/bin/systemctl restart snmp_exporter	;

# Start services at boot
/bin/systemctl enable snmp_exporter	;

# Show services status
#====#===========#=====
/bin/systemctl status snmp_exporter	;
