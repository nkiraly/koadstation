#!/bin/bash

echo "dbdevu14 Provisioning Step 101 - mysql"

# ansible should have been confirmed in step 010
ansible=`which ansible 2>/dev/null`

# stop on error
set -e

# install mysql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m apt \
  -a "name=mysql-server,libmysqlclient-dev
      state=present"

# enable mysql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=mysql
      enabled=yes"

# start mysql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=mysql
      state=started"
