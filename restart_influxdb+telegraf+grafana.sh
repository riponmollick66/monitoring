# Restart the services
#====#===========#===========
/bin/systemctl restart influxdb telegraf grafana-server	;

# Start services at boot
#========#==========#=====
/bin/systemctl enable influxdb telegraf grafana-server;

# Show services status
#====#===========#===========
/bin/systemctl status influxdb telegraf grafana-server;
