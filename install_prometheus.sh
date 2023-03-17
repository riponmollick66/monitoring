# Required Commands
#=====#========#=====
sudo groupadd --system prometheus	;
sudo useradd -s /sbin/nologin --system -g prometheus prometheus	;
sudo mkdir /var/lib/prometheus	;
for i in rules rules.d files_sd; do sudo mkdir -p /etc/prometheus/${i}; done	;
cd /opt/prometheus	;
/usr/bin/wget https://github.com/prometheus/prometheus/releases/download/v2.42.0/prometheus-2.42.0.linux-amd64.tar.gz	;
tar xvf prometheus*.tar.gz	;
cd prometheus*	;
sudo mv prometheus promtool /usr/local/bin/	;
sudo mv prometheus.yml /etc/prometheus/prometheus.yml	;
sudo mv consoles/ console_libraries/ /etc/prometheus/	;
rm -rf /opt/prometheus	;

# create systemd service
#========#==========#======
sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target
[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP \$MAINPID
ExecStart=/usr/local/bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/var/lib/prometheus \
  --web.console.templates=/etc/prometheus/consoles \
  --web.console.libraries=/etc/prometheus/console_libraries \
  --web.listen-address=0.0.0.0:9090 \
  --web.external-url=
SyslogIdentifier=prometheus
Restart=always
[Install]
WantedBy=multi-user.target
EOF

# Set Permissions
#======#=====#=====
for i in rules rules.d files_sd; do sudo chown -R prometheus:prometheus /etc/prometheus/${i}; done
for i in rules rules.d files_sd; do sudo chmod -R 775 /etc/prometheus/${i}; done
sudo chown -R prometheus:prometheus /var/lib/prometheus/

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