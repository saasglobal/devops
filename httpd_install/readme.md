## Just follow procedure step by step for  apache  compile verstion installation latest  apache  2.4.39 mod_wsg 4.6.5  

## Install compile dependency package

    yum groupinstall "Development Tools" -y 
    yum install expat-devel pcre pcre-devel openssl openssl-devel libssl-dev-y 

##  Dowload and compile http2  

Download the file   

     wget https://github.com/nghttp2/nghttp2/releases/download/v1.38.0/nghttp2-1.38.0.tar.gz

Unzip the File

    tar -xf nghttp2-1.38.0.tar.gz

Get Enter into the folder 

    cd nghttp2-1.38.0  
Configure All File

    ./configure  
Build the application

    make
Install the application

    make install 

 


## Download  apache  latest package and compile  

Download Apache Package 2.4   

    wget  http://www.apache.org/dist/httpd/httpd-2.4.39.tar.gz

Unzip the Package 2.4

    tar -xf httpd-2.4.39.tar.gz
Download Apache Package 1.7.0

    wget  http://www.apache.org/dist/apr/apr-1.7.0.tar.gz
Unzip the Package 1.7.0

    tar -xf apr-1.7.0.tar.gz  
Download Apache Package 1.6.1

    wget  [https://www-eu.apache.org/dist//apr/apr-util-1.6.1.tar.gz

  Unzip the Package 1.6.1

    tar -xf apr-util-1.6.1.tar.gz
Move apr1.7.0 file to the /srclib/apr Folder
  

    mv apr-1.7.0 httpd-2.4.39/srclib/apr  
Move 1.6.1 file to the /srclib/apr-util 

    mv apr-util-1.6.1 httpd-2.4.39/srclib/apr-util  
    cd httpd-2.4.39  
Configure the file

    ./configure --enable-ssl --enable-so --enable-http2 --with-mpm=event --enable-mods-shared --enable-http --enable-info --enable-cgi --enable-vhost-alias --enable-rewrite --enable-mods-shared --with-included-apr --with-ssl=/etc/pki/tls --prefix=/usr/local/apache2  
Buile the application

    make 

 Install the application

    make install

  

## Download and compile mod_wsgi

Download the mod_wsgi file

   

    wget https://github.com/GrahamDumpleton/mod_wsgi/archive/4.6.5.tar.gz
Unzip the Downloaded file   

 

    tar -xf 4.6.5.tar.gz

Get Enter into the folder

    cd mod_wsgi-4.6.5

Configure the file
   

     ./configure --with-apxs=/usr/local/apache2/bin/apxs --with-python=/usr/bin/python2.7  

Build the application    

    make

  
Install the application

    make install

  

## Now configure httpd  
Go to Apache Config folder

    cd /usr/local/apache2/conf

   Edit the httpd. config file

    vim httpd.conf

Copy these into that file

    Include conf/extra/httpd-mpm.conf
    Include conf/extra/prism.conf  
    LoadModule ssl_module modules/mod_ssl.so  
    LoadModule http2_module modules/mod_http2.so  
    LoadModule deflate_module modules/mod_deflate.so  
    LoadModule wsgi_module modules/mod_wsgi.so 

 

## Make  apache  service  
Edit the httpd.service 

    vim /etc/systemd/system/httpd.service

 
Move these file into the file     

    [Unit]  
    Description=The  Apache  HTTP Server  
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
    	
   Start the Apache 
  
    service httpd start 

 

## Now configure a virtual host with http2  
Get into the Apache Config folder

    cd /usr/local/apache2/conf/extra

Create and edit the prism.conf file    

    vim prism.conf

  
Copy these file into the prism.conf file 

    <VirtualHost *:443>  
    ServerName [excel.prismerp.net](http://excel.prismerp.net/)  
    Alias /static /var/www/html/prismerp/excel_prismerp_net/divineba/public/static  
    WSGIScriptAlias / /var/www/html/prismerp/excel_prismerp_net/divineba/public/divineba.wsgi  
    SSLEngine on  
    SSLCertificateFile /etc/ssl/ssl/star_prismerp_net.crt  
    SSLCertificateKeyFile /etc/ssl/ssl/star_prismerp_net.key  
    SSLCACertificateFile /etc/ssl/ssl/star_prismerp_net.ca-bundle  
    SSLProtocol all -SSLv3 -TLSv1 -TLSv1.1  
    Protocols h2 http/1.1  
     CustomLog "|/usr/sbin/rotatelogs -l /var/log/httpd/excel_prismerp_net/access_log.%Y-%m-%d 3600" combined  
    ErrorLog "|/usr/sbin/rotatelogs -l /var/log/httpd/excel_prismerp_net/error_log.%Y-%m-%d 3600"  
     <Directory /var/www/html/prismerp/excel_prismerp_net/divineba/public>  
    <IfVersion < 2.2>  
    Order allow,deny  
    Allow from all  
    </IfVersion>  
    <IfVersion >=  2.4>  
    Require all granted  
    </IfVersion>  
      AddOutputFilterByType DEFLATE text/css text/javascript application/javascript application/x-javascript text/html text/plain text/xml  
    </Directory>  
    </VirtualHost>  
    <VirtualHost *:80>  
    ServerName  [excel.prismerp.net](http://excel.prismerp.net/)  
    Redirect permanent /  [https://excel.prismerp.net/](https://excel.prismerp.net/)  
    </VirtualHost>  




