cd /etc/yum.repos.d/

wget iiabd.org/static/mongo.repo

sudo yum install -y mongodb-org

echo "exclude=mongodb-org,mongodb-org-server,mongodb-org-shell,mongodb-org-mongos,mongodb-org-tools">>/etc/yum.conf

service mongod start

chkconfig mongod on