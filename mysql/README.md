# MySQL Cluster

## Environment

### Management

- Private IP: 172.31.52.186
- Remote access: ssh -i boatkey.pem ubuntu@54.202.10.46
- Role: MySQL NDB Cluster Management Server / Docker Swarm Manager

### Data 1

- Private IP: 172.31.53.216
- Remote access: ssh -i boatkey.pem ubuntu@34.215.174.20
- Role: MySQL NDB Data Node

### Data 2

- Private IP: 172.31.61.27
- Remote access: ssh -i boatkey.pem ubuntu@34.216.117.73
- Role: MySQL NDB Data Node

### Data 3

- Private IP: 172.31.56.189
- Remote access: ssh -i boatkey.pem ubuntu@54.201.117.52
- Role: MySQL NDB Data Node

### Data 4

- Private IP: 172.31.49.140
- Remote access: ssh -i boatkey.pem ubuntu@18.236.116.8
- Role: MySQL NDB Data Node

### Worker 1

- Private IP: 172.31.48.221
- Remote access: ssh -i boatkey.pem ubuntu@54.190.172.233
- Role: MySQL NDB API Server / Docker Swarm Worker

### Worker 2

- Private IP: 172.31.48.110
- Remote access: ssh -i boatkey.pem ubuntu@35.160.227.14
- Role: MySQL NDB API Server / Docker Swarm Worker

## Instalation (Ubuntu Linux 18.04)

Reference: https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-cluster-install

- Download the MySQL APT Repository:

`wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb`

- Install the downloaded release package:

`sudo dpkg -i mysql-apt-config_0.8.13-1_all.deb`

*During the instalation of the release package select the installations option, in this case only the Mysql Cluster 7.6.*

- Update the package information:

`sudo apt-get update`

- Install the components for MySQL Cluster API Server:

`sudo apt-get install mysql-cluster-community-server`

*You will be asked to provide a password for the root user for your MySQL Cluster API Server*

- Install the executables for MySQL Cluster Management Server:

`sudo apt-get install mysql-cluster-community-management-server`

- Install the executables for MySQL Cluster Data Node:

`sudo apt-get install mysql-cluster-community-data-node`

## Configuration

Reference: https://dev.mysql.com/doc/refman/8.0/en/mysql-cluster-install-configuration.html

### Configuring the MySQL NDB Cluster Management Servers

- Create/edit config file:

`sudo mkdir /var/lib/mysql-cluster`

`sudo vim /var/lib/mysql-cluster/config.ini`

- Create and enable startup script for the *MySQL NDB Cluster Management Server.*:

`sudo vim /etc/systemd/system/ndb_mgmd.service`

`sudo systemctl enable ndb_mgmd`

`sudo systemctl start ndb_mgmd`

### Configuring the MySQL NDB Data Nodes

- Create/edit config file:

`sudo vim /etc/my.cnf`

- Create data dir:

`sudo mkdir -p /usr/local/mysql/data`

- Create and enable the startup script for the *MySQL NDB Data Node Daemon.*:

`sudo vim /etc/systemd/system/ndbd.service`

`sudo systemctl enable ndbd`

`sudo systemctl start ndbd`

### Configuring the MySQL NDB API Servers

- Create/edit config file:

`sudo vim /etc/my.cnf`

- Create and start the startup script for the *MySQL NDB API Server*:

`sudo vim /etc/systemd/system/mysqld.service`

`sudo systemctl enable mysqld`

`sudo systemctl start mysqld`

- Comment the line **#bind-address = 127.0.0.1** in the file */etc/mysql/mysql.conf.d/mysqld.cnf* to allow remote connections.

Troubleshoot 1: Because it was created only one vm image for all 3 roles, the *mysqld* does not start.
To solve this problem, it is necessary to add the line **/etc/my.cnf r** in the file */etc/apparmor.d/usr.sbin.mysqld* and then udate the apparmor:

`sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.mysqld`

Troubleshoot 2: Create the */var/run/mysqld* dir and change it ownership to *mysql:mysql*:

`sudo mkdir /var/run/mysqld`
`sudo chown mysql:mysql /var/run/mysqld`

## Cluster Management

- Show the cluster configuration:

`sudo ndb_mgm -e show`

- Safe shutdown:

`sudo ndb_mgm -e shutdown`

- Reload config file:

`sudo ndb_mgmd --reload --config-file=/var/lib/mysql-cluster/config.ini`

## Logs

- Management Server:

`cat /var/lib/mysql-cluster/ndb_50_cluster.log`

`cat /var/lib/mysql-cluster/ndb_50_out.log`

- Data Node:

`cat /usr/local/mysql/data/ndb_1_error.log`

`cat /usr/local/mysql/data/ndb_1_out.log`

- MySQL API Server:

`cat /var/log/mysql/error.log`
