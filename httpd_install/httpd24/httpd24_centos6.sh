#!/bin/bash
centosversion=`rpm -qa \*-release | grep -Ei "oracle|redhat|centos" | cut -d"-" -f3`
echo "CentOS $centosversion server detected, Apache 2.4 will install and configre as per centos $centosversion"

mv /etc/httpd/ /etc/httpd_old_apache_2.2/

mv /var/log/httpd/ /var/log/httpd_old_apache_2.2/

yum remove httpd* -y

yum -y install epel-release

yum -y install centos-release-scl-rh centos-release-scl

yum -y install httpd24 httpd24-httpd-devel httpd24-httpd httpd24-httpd-tools httpd24-libnghttp2 httpd24-runtime httpd24-apr httpd24-apr-util httpd24-apr-devel httpd24-apr-util-devel httpd24-mod_ssl

# Check if version el6

if [ $centosversion -eq "6" ]; then
echo 
echo "#######################################"
echo "# CentOS 6 OS detected"
echo "#######################################"
echo
echo
echo "Installing service for CentOS 6"
ln -s /etc/init.d/httpd24-httpd /etc/init.d/httpd 
fi

if [ $centosversion -eq "7" ]; then
echo
echo "#######################################"
echo "# CentOS 7 OS detected"
echo "#######################################"
echo
echo
echo "Installing service for CentOS 7"
ln -s /usr/lib/systemd/system/httpd24-httpd.service /usr/lib/systemd/system/httpd.service
exit 0
fi

ln -s /opt/rh/httpd24/root/etc/httpd /etc/httpd

ln -s /var/log/httpd24 /var/log/httpd

ln -s /opt/rh/httpd24/root/usr/bin/* /usr/bin/

ln -s /opt/rh/httpd24/root/usr/sbin/* /usr/sbin/