#!/usr/local/bin/bash

echo "dbdevf2 Provisioning Step 020 - tools"

# ansible should have been confirmed in step 010
ansible=`which ansible 2>/dev/null`

# stop on error
set -e

# install tools with ansible module pkgng
$ansible all \
  -i 'localhost,' \
  -c local \
  -m pkgng \
  -a "name=unzip,zip state=present"
