#!/bin/bash

echo "tiledraweru14 Provisioning Step 030 - build map tile database"

# stop on error
set -e

cd /vagrant

# ansible should have been confirmed in bootstrap step 010
ansible=`which ansible-playbook 2>/dev/null`

# configure and build map tile database with ansible
$ansible \
  -i 'localhost,' \
  -c local \
  provisioning/step-030_build-database.yml
