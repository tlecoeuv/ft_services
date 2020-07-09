#!/bin/sh

nohup ./init_db.sh > /dev/null 2>&1 &
/usr/bin/mysql_install_db --user=root --datadir="/var/lib/mysql"
/usr/bin/mysqld_safe --datadir="/var/lib/mysql"
