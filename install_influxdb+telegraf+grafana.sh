# Adding Repository
/usr/bin/apt update	-y ;
/usr/bin/apt install -y curl gnupg wget	;
/usr/bin/curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add - ;
source /etc/lsb-release ;
echo "deb https://repos.influxdata.com/${DISTRIB_ID,,} ${DISTRIB_CODENAME} stable" | sudo tee /etc/apt/sources.list.d/influxdb.list ;
/usr/bin/wget -q https://repos.influxdata.com/influxdb.key	;
echo '23a1c8836f0afc5ed24e0486339d7cc8f6790b83886c4c96995b88a061c5bb5d influxdb.key' | sha256sum -c && cat influxdb.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdb.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdb.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list ;
/usr/bin/apt-get install -y adduser libfontconfig1	;
/usr/bin/wget https://dl.grafana.com/enterprise/release/grafana-enterprise_9.4.3_amd64.deb	;

# Install required packages
/usr/bin/apt update	-y ;
/usr/bin/apt-get install -y influxdb telegraf;
/usr/bin/dpkg -i grafana-enterprise_9.4.3_amd64.deb	;

# Load the new service file
/bin/systemctl daemon-reload	;

# Start services at boot
/bin/systemctl enable influxdb telegraf grafana-server;

# Add user to Influxdb
#====#===========#===========
# influx	
# CREATE USER "admin" WITH PASSWORD 'admin' WITH ALL PRIVILEGES
# show users
# exit

# Configuring Influxbd Authentication
#=============#==============#==========
# sudo nano /etc/influxdb/influxdb.conf
# Locate the [http] section, uncomment the auth-enabled option, and set its value to true

# Configuring Telegraf
#====#===========#===========
# nano /etc/telegraf/telegraf.conf
# Locate the [outputs.influxdb] section and provide the username and password


# See telegraf storing in the database
#=============#==============#==========
# influx -username 'admin' -password 'admin'
# show databases
# use telegraf
# show measurements
# exit

# Restart the services
#====#===========#===========
/bin/systemctl restart influxdb telegraf grafana-server	;

# Show services status
#====#===========#===========
/bin/systemctl status influxdb telegraf grafana-server;