#!/usr/local/bin/bash

echo "dbdevf3 Provisioning Step 102 - redis"

# ansible should have been confirmed in step 010
ansible=`which ansible 2>/dev/null`

# stop on error
set -e

# install redis
$ansible all \
  -i 'localhost,' \
  -c local \
  -m pkgng \
  -a "name=redis
      state=present"

# enable redis
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=redis
      enabled=yes"

# start redis
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=redis
      state=started"
