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
  -a "name=postgresql94-server
      state=present"

# enable postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=postgresql
      enabled=yes"

# create postgresql data directory
$ansible all \
  -i 'localhost,' \
  -c local \
  -m file \
  -a "path=/opt/db/pgsql/data
      state=directory
      owner=pgsql
      group=pgsql
      mode=0700"

# set postgresql data directory in rc.conf
$ansible all \
  -i 'localhost,' \
  -c local \
  -m lineinfile \
  -a "dest=/etc/rc.conf
      regexp=^postgresql_data=
      line='postgresql_data=\"/opt/db/pgsql/data\"'
      state=present"

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
  -a "/usr/local/etc/rc.d/postgresql initdb"

# start postgresql
$ansible all \
  -i 'localhost,' \
  -c local \
  -m service \
  -a "name=postgresql
      state=started"
