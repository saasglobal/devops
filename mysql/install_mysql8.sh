yum localinstall https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm -y

yum install mysql-community-server mysql-community-devel mysql-community-libs -y

systemctl start mysqld.service ## use restart after update

systemctl enable mysqld.service


grep 'A temporary password is generated for root@localhost' /var/log/mysqld.log |tail -1


/usr/bin/mysql_secure_installation



firewall-cmd --permanent --zone=public --add-service=mysql

firewall-cmd --permanent --zone=public --add-port=3306/tcp

systemctl restart firewalld.service
