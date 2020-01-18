#!/bin/bash

# Java 1.8 and Open JDK 1.8 is useing by Tomcat 9 and BIRT viewer : 3.7.0

yum install java-1.8.0-openjdk-devel wget -y

cd /tmp

wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.26/bin/apache-tomcat-9.0.26.tar.gz

tar -xvf apache-tomcat-9.0.26.tar.gz

mv apache-tomcat-9.0.26/ /opt/tomcat

# Createing prismerp user for tomcat.

useradd -m -U -d /opt/tomcat -s /bin/false apache

sudo chown -R apache: /opt/tomcat

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

echo "export CATALINA_HOME='/opt/tomcat/'" >> ~/.bashrc
source ~/.bashrc

systemctl daemon-reload

systemctl start tomcat

systemctl enable tomcat

systemctl status tomcat

echo "vi /opt/tomcat/conf/tomcat-users.xml"

# Need to add on tomcat </tomcat-users> section.

cat << EOF
<role rolename="admin-gui" />
<user username="prism" password="MSIRA@2019!!" roles="manager-gui,admin-gui"

>> /opt/tomcat/conf/tomcat-users.xml
EOF

firewall-cmd --permanent --zone=public --add-port=8080/tcp

systemctl restart firewalld.service
