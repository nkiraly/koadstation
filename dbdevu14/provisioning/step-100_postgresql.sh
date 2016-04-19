#!/bin/bash

echo "dbdevu14 Provisioning Step 100 - postgresql"

# ansible should have been confirmed in step 010
ansible=`which ansible 2>/dev/null`

# stop on error
set -e

# install postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m apt \
  -a "name=postgresql-server-dev-9.5,postgresql-contrib-9.5
      state=present"

# enable postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=postgresql
      enabled=yes"

# start postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=postgresql
      state=started"
