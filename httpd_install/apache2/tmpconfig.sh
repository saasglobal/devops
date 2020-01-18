vim httpd.conf
uncommet
Include conf/extra/httpd-mpm.conf
Include conf/extra/prism.conf
LoadModule ssl_module modules/mod_ssl.so
LoadModule http2_module modules/mod_http2.so
LoadModule deflate_module modules/mod_deflate.so
LoadModule wsgi_module modules/mod_wsgi.so
******************************************************************************************************************************************************
Steps7: make apache service
[root@localhost systemd]# vim /etc/systemd/system/httpd.service
[Unit]
Description=The Apache HTTP Server
After=network.target
[Service]
Type=forking
ExecStart=/usr/local/apache2/bin/apachectl -k start
ExecReload=/usr/local/apache2/bin/apachectl -k graceful
ExecStop=/usr/local/apache2/bin/apachectl -k graceful-stop
PIDFile=/usr/local/apache2/logs/httpd.pid
PrivateTmp=true
[Install]
WantedBy=multi-user.target
[root@localhost systemd]# :x
[root@localhost systemd]# service httpd start