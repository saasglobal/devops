cd /etc/yum.repos.d && wget https://repo.codeit.guru/codeit.el`rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release)`.repo

yum install -y epel-release


cd /etc/yum.repos.d && wget https://repo.codeit.guru/codeit.mainline.el`rpm -q --qf "%{VERSION}" $(rpm -q --whatprovides redhat-release)`.repo

yum update -y

yum install httpd httpd-tools apr-devel apr-util-devel openssl-devel openssl httpd-devel -y 