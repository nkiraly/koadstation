#!/usr/local/bin/bash

echo "dbdevf3 Provisioning Step 101 - mysql"

# ansible should have been confirmed in step 010
ansible=`which ansible 2>/dev/null`

# stop on error
set -e

# install mysql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m pkgng \
  -a "name=mysql57-server
      state=present"

# enable mysql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=mysql-server
      enabled=yes"

# create mysql data directory
$ansible all \
  -i 'localhost,' \
  -c local \
  -m file \
  -a "path=/opt/db/mysql/data
      state=directory
      owner=mysql
      group=mysql
      mode=0700"

# set mysql data directory in rc.conf
$ansible all \
  -i 'localhost,' \
  -c local \
  -m lineinfile \
  -a "dest=/etc/rc.conf
      regexp=^mysql_dbdir=
      line='mysql_dbdir=\"/opt/db/mysql/data\"'
      state=present"

# start mysql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=mysql-server
      state=started"
