#!/bin/bash

echo "dbdevu14 Provisioning Step 102 - redis"

# ansible should have been confirmed in step 010
ansible=`which ansible 2>/dev/null`

# stop on error
set -e

# install redis
$ansible all \
  -i 'localhost,' \
  -c local \
  -m apt \
  -a "name=redis-server
      state=present"

# enable redis
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=redis-server
      enabled=yes"

# specify redis password
$ansible all \
  -i 'localhost,' \
  -c local \
  -m lineinfile \
  -a "dest=/etc/redis/redis.conf
      regexp=^requirepass\s+
      line='requirepass janeyg1'
      state=present"

# start redis
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=redis-server
      state=started"
