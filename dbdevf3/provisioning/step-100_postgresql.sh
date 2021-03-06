#!/usr/local/bin/bash

echo "dbdevf2 Provisioning Step 100 - postgresql"

# ansible should have been confirmed in step 010
ansible=`which ansible 2>/dev/null`

# stop on error
set -e

# install postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m pkgng \
  -a "name=postgresql95-server,postgresql95-contrib
      state=present"

# enable postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=postgresql
      enabled=yes"

# set postgresql initdb flags in rc.conf
$ansible all \
  -i 'localhost,' \
  -c local \
  -m lineinfile \
  -a "dest=/etc/rc.conf
      regexp=^postgresql_initdb_flags=
      line='postgresql_initdb_flags=\"--encoding=utf8\"'
      state=present"

# initdb postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m command \
  -a "/usr/local/etc/rc.d/postgresql initdb
      creates=/usr/local/pgsql/data/postgresql.conf"

# start postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=postgresql
      state=started"
