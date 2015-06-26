#!/bin/bash

echo "tiledraweru14 Provisioning Step 020 - server components"

# stop on error
set -e

cd /vagrant

# ansible should have been confirmed in bootstrap step 010
ansible=`which ansible-playbook 2>/dev/null`

# provision server component packages and configuration with ansible
$ansible \
  -i 'localhost,' \
  -c local \
  provisioning/step-020_server-components.yml
