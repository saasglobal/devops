yum install -y https://centos7.iuscommunity.org/ius-release.rpm

yum update -y

yum install -y python36u python36u-libs python36u-devel

echo "export PIPENV_VENV_IN_PROJECT=1" >> ~/.bashrc

ln -s /usr/bin/pip3.6 /usr/bin/pip3

ln -s /usr/bin/python3.6 /usr/bin/python3

pip3 install --upgrade pip setuptools wheel

pip3 install pipenv

python3 -V

curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
