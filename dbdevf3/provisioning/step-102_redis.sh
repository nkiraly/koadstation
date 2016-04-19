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

# specify redis password
$ansible all \
  -i 'localhost,' \
  -c local \
  -m lineinfile \
  -a "dest=/usr/local/etc/redis.conf
      regexp=^requirepass\s+
      line='requirepass janeyg1'
      state=present"

# start redis
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=redis
      state=started"
