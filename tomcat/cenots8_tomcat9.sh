#!/bin/bash

# Install Open JDK 13

yum install java-13-openjdk-devel wget zip -y

cd /tmp && wget https://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.27/bin/apache-tomcat-9.0.27.zip && unzip apache-tomcat-9.0.27.zip

mv apache-tomcat-9.0.27 /opt/tomcat9.0.27 && ln -sf /opt/tomcat9.0.27 /opt/tomcat


# Createing prismerp user for tomcat.

useradd -m -U -d /opt/tomcat -s /bin/false tomcat

sudo chown -R tomcat: /opt/tomcat

# haveing warinning need to update

sh -c 'chmod +x /opt/tomcat/bin/*.sh'

# Need to create service manually.

echo "vi /etc/systemd/system/tomcat.service"

# Type flowing Line.

cat << EOF
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=apache
Group=apache

Environment="JAVA_HOME=/usr/lib/jvm/jre"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/"
Environment="CATALINA_HOME=/opt/tomcat/"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target

EOF

echo "export CATALINA_HOME='/opt/tomcat/'" >> ~/.bashrc && echo "export CATALINA_HOME='/opt/tomcat/'" >> ~/.zshrc

source ~/.bashrc

systemctl daemon-reload && systemctl start tomcat && systemctl enable tomcat && systemctl status tomcat

echo "vi /opt/tomcat/conf/tomcat-users.xml"

# Need to add on tomcat </tomcat-users> section.

cat << EOF
<role rolename="admin-gui" />
<user username="prism" password="MSIRA@2019!!" roles="manager-gui,admin-gui"

>> /opt/tomcat/conf/tomcat-users.xml
EOF

yum install httpd-devel -y && sudo setsebool -P httpd_can_network_connect 1 && sudo setsebool -P httpd_can_network_relay 1 && sudo setsebool -P httpd_graceful_shutdown 1 && sudo setsebool -P nis_enabled 1 && firewall-cmd --permanent --zone=public --add-port=8080/tcp && firewall-cmd --permanent --zone=public --add-port=80/tcp && firewall-cmd --permanent --zone=public --add-port=443/tcp

sudo firewall-cmd --reload