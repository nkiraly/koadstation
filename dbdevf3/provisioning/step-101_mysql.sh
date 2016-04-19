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

# start mysql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=mysql-server
      state=started"

# echo provisioned password to console
cat /root/.mysql_secret
