yum install gcc openssl-devel bzip2-devel   # On CentOS systems 
cd /usr/src
wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz
tar xzf Python-2.7.16.tgz

cd Python-2.7.16
./configure --enable-optimizations
make altinstall

cd Python-2.7.16
./configure --enable-optimizations
make altinstall

curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"



sudo yum update # update yum 
sudo yum install centos-release-scl # install SCL
sudo yum install python27 # install Python 2.7

scl enable python27 bash


cd /opt/rh/python27/root/usr/bin/ # cd to the directory where SCL installs python 
sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./easy_install-2.7
pip

sudo LD_LIBRARY_PATH=$LD_LIBRARY_PATH ./pip2.7 install requests