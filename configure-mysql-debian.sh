#!/bin/bash
sudo -i <<EOFF
apt-get update
apt-get install extrepo
sed -i -e 's/# -/-/g;' /etc/extrepo/config.yaml
extrepo update
extrepo enable mysql
apt-get update
apt-get install mysql-server

echo "bind-address = 0.0.0.0" >> /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root --password=$rootPword <<EOF
CREATE USER 'admin'@'localhost' IDENTIFIED BY '$pword';
CREATE USER 'admin'@'%' IDENTIFIED BY '$pword';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
EOF

systemctl restart mysql.service
EOFF
