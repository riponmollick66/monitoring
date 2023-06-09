# Required Commands
#=====#========#=====
/usr/bin/wget https://github.com/prometheus/prometheus/releases/download/v2.44.0/prometheus-2.44.0.linux-amd64.tar.gz	;
tar xvf prometheus-2.44.0.linux-amd64.tar.gz	;
/bin/mv prometheus-2.44.0.linux-amd64 /etc/prometheus/

# create systemd service
#========#==========#======
sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target
[Service]
ExecStart=/etc/prometheus/prometheus --config.file=/etc/prometheus/prometheus.yml
Restart=always
[Install]
WantedBy=multi-user.target
EOF

# Reload services file
#========#=========#====
/bin/systemctl daemon-reload	;

# Restart the services
#====#===========#======
/bin/systemctl restart prometheus	;

# Start services at boot
/bin/systemctl enable prometheus	;

# Show services status
#====#===========#=====
/bin/systemctl status prometheus	;
