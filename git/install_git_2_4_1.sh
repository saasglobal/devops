yum install  epel-release wget curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker asciidoc xmlto docbook2x docbook2X -y

ln -s /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi

cd /tmp/ && wget https://www.kernel.org/pub/software/scm/git/git-2.4.1.tar.gz && tar -xvzf git-2.4.1.tar.gz && cd git-2.4.1 

make prefix=/usr all doc info

make prefix=/usr install install-doc install-html install-info 

git config --global http.sslVerify false

git --version